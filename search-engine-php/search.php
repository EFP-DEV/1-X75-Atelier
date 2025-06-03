<pre>
<?php

// var_dump($_GET);

$sql = "SELECT * FROM `item`";
$bindings = [];
$conditions = [];

$operators = [
    'year_min' => '>=',
    'year_max' => '<=',
    'price_min' => '>=',
    'price_max' => '<=',
];

foreach($_GET as $key => $value) {
    if ($value === '' || $value === null) {
        continue;
    }
    $op = $operators[$key] ?? '=';
    $conditions[] = "`$key` $op :$key";
    $bindings[":$key"] = $value;
}

var_dump($sql . " WHERE " . implode(' AND ', $conditions));
var_dump($bindings);
die;
