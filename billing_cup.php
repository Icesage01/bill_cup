<?php

$time_format = 'Y-m-d';
$week_sec = 3600 * 24 * 7; // 7 дней
// Отправная точка, от которой будет идти подсчёт НАЗАД
$time_start = (isset($_POST['time_start'])
			  && !empty($_POST['time_start']))
				? strtotime($_POST['time_start'])
				: strtotime('midnight', time());

$time_end = (isset($_POST['time_end'])
			&& !empty($_POST['time_end']))
				? strtotime($_POST['time_end'])
				: strtotime('midnight', $time_start - $week_sec * 4);

?>

<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
</head>
<body>
<form action="<?=$_SERVER["SCRIPT_NAME"]?>" method="POST">
Период с <input type="text" name="time_end" value="<?= date($time_format, $time_end) ?>">
по <input type="text" name="time_start" value="<?= date($time_format, $time_start) ?>">
<input type="submit" value="Построить">
</form>
<h3>Биллинг ЦУП</h3>
<?php

if (file_exists($css = 'style.css')) {
	print_r(file_get_contents($css));
}

if (empty($_POST)) {
	exit(0);
} elseif (!file_exists($ini_file = dirname(__FILE__) . '/' . basename(__FILE__, 'php') . 'ini')) {
	die('ERROR: Can\'t open INI file for ' . basename(__FILE__, '.php'));
}

print_r(sprintf("<h4>Статистика за период с %s по %s</h4>",
				date($time_format, $time_end),
				date($time_format, $time_start)));

$data = [];
$min2price = ['8000' => 4, '3000' => 6, '0' => 8];
$max_price = end($min2price);

$ini = parse_ini_file($ini_file, TRUE);
$port = (isset($ini['db']['port'])) ? $ini['db']['port'] : '3306';
$required_values = ['username', 'password', 'hostname', 'database'];
foreach ($required_values as $val_name) {
	if (!isset($ini['db'][$val_name])) {
		die("Param \"{$val_name}\" not specified in INI file.");
	}
	${$val_name} = $ini['db'][$val_name];
}

$mysqli = new mysqli($hostname, $username, $password, $database, $port);

$sql_get_billsec = [];
$last_time = $time_start;
for ($i = 1; $i <= 4; $i++) {
	$time = $time_start - $week_sec * $i;
	$time = ($time < $time_end) ? $time_end : $time;
	$sql_get_billsec[] = "SELECT
							`datetime_event`,
							SUM(`billsec`) AS `sec`
						  FROM `{$database}`.`[[TABLE_NAME]]`
						  WHERE `datetime_event` BETWEEN '{$time}' AND '{$last_time}'";
	$last_time = $time;
}
$sql_get_billsec = implode("UNION ", $sql_get_billsec);

$sql = "
SELECT
  `u`.`id` AS `id`,
  `u`.`name` AS `name`,
  `email`,
  `OWNER`,
  SUM(`amount`) AS `balance`,
  COUNT(DISTINCT `b`.`id`) AS `bots_cnt`,
  `u`.`bots_discount`,
  `u`.`analytics_discount`
FROM
  `{$database}`.`users` AS `u`
  LEFT JOIN `{$database}`.`transactions` AS `t`
    ON `u`.`id` = `t`.`user_id`
  LEFT JOIN `{$database}`.`bots` AS `b`
    ON `b`.`user_id` = `u`.`id`
WHERE `OWNER` > 0
GROUP BY `b`.`user_id`;";

$res = $mysqli->query($sql);
while($row = $res->fetch_assoc()) {
	$id = $row['id'];
	$data[$id] = $row;
	$data[$id]['analytics_price_for_min'] = ($max_price - ($max_price / 100 * $row['analytics_discount']));
	$data[$id]['bot_price_for_min'] = ($max_price - ($max_price / 100 * $row['bots_discount']));
	if ($row['bots_cnt'] == 0) {
		$postfix = 'call';
		$price_col = 'analytics_price_for_min';
		$discount_col = 'analytics_discount';
	} else {
		$postfix = 'conversations';
		$price_col = 'bot_price_for_min';
		$discount_col = 'bots_discount';
	}
	
	$data[$id]['tariff_type'] = $postfix;
	$table_name = "events_{$postfix}_" . sprintf("%08s", $row['OWNER']);
	$sql = str_replace('[[TABLE_NAME]]', $table_name, $sql_get_billsec);
	$cdr_data = $mysqli->query($sql);
	while ($cdr = $cdr_data->fetch_assoc()) {
		$data[$id]['call_data'][] = round($cdr['sec'] / 60);
	}
	
	while (count($data[$id]['call_data']) < 4) {
		array_push($data[$id]['call_data'], 0);
	}
	$sum = array_sum($data[$id]['call_data']);
	foreach ($min2price as $min => $price) {
		if ((int) $sum >= $min) {
			if ($row[$discount_col]) {
				$price = round($price - ($price / 100 * $row[$discount_col]), 1);
			}
			$data[$id][$price_col] = $price;
			// Во избежания возможного деления на 0, доп. проверки
			if (($weeks = count($data[$id]['call_data'])) == 0 || ($avg = $sum / $weeks) == 0) {
				$remainder = 0;
			} else {
				$remainder = floor(($row['balance'] / $price) / $avg);
			}
			$data[$id]['remainder'] = $remainder;
			break;
		}
	}
}

echo <<<HTML
<table cellpadding="0" cellspacing="0" border="1" width="200pt">
<tr style="font-weight:bold">
	<td>Название клиента</td>
	<td>Остаток</td>
	<td>Хватит на дней</td>
	<td>Кол-во ботов</td>
	<td>Цена минуты бота</td>
	<td>Скидка на ботов</td>
	<td>Открутка ботов за 4 недели, минут</td>
	<td>Цена минуты РА</td>
	<td>Скидка на РА</td>
	<td>Открутка аналитики за 4 недели, минут</td>
</tr>
HTML;
foreach ($data as $user_id => $user_data) {
	$deflection_bot = ($user_data['tariff_type'] == 'conversations')
						? implode(' / ', $user_data['call_data'])
						: '';
						
	$deflection_analytics = ($user_data['tariff_type'] == 'call')
							? implode(' / ', $user_data['call_data'])
							: '';			
	echo <<<HTML
<tr>
	<td>{$user_data['name']}</td>
	<td>{$user_data['balance']}</td>
	<td>{$user_data['remainder']}</td>
	<td>{$user_data['bots_cnt']}</td>
	<td>{$user_data['bot_price_for_min']}</td>
	<td>{$user_data['bots_discount']}</td>
	<td>{$deflection_bot}</td>
	<td>{$user_data['analytics_price_for_min']}</td>
	<td>{$user_data['analytics_discount']}</td>
	<td>{$deflection_analytics}</td>
<tr>
HTML;
}

?>