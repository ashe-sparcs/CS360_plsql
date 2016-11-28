<?php
	function cal_center_price($conn){
		$price=0;
		//implement
		// DO NOT USE A PL/SQL STORED FUNCTION
        $sum_min=INF;
		$pc_cursor = $conn->query("select price from pc");
		while($tuple = $pc_cursor->fetchRow()) {
			$sum_temp=0;
			$pc_cursor2 = $conn->query("select price from pc");
			while($tuple2 = $pc_cursor2->fetchRow()) {
				$sum_temp += abs($tuple["price"] - $tuple2["price"]);
			}
			if ($sum_temp < $sum_min) {
				$sum_min = $sum_temp;
				$price = $tuple["price"];
			}
		}
		return $price;
	}
?>
<?php
	$page_title = 'CS360 / '.basename(__FILE__);
	include('../includes/header.html');	
	include('../Config/db.connect.php');
	if (!PEAR::isError($conn)){
		echo '<p>The result of finding center price in PC table</p>';
		$conn->autoCommit(true);		

		//Calculate by using CLI	
		$time_start = microtime(true);			
		$price1= cal_center_price($conn);
		$execution_time = microtime(true) - $time_start;
		echo '<p>Execution time of the direct calculation: ',$execution_time,' seconds </p>';

		//Calculate by using PL/SQL	
		$time_start = microtime(true);
		$res = $conn->query("select FindCenterPrice from dual");
		$price2= $res->fetchRow()[0];
		$execution_time = microtime(true) - $time_start;
		echo '<p>Execution time of the stored function: ',$execution_time,' seconds </p>';

		$price = $price1 == $price2 ? $price1 : -1;

		if(DB::isError($res)){
			print_error($res);
		}

		echo '<p>The center price : ',$price,'</p>';

		$conn->disconnect();
	}
	include('../includes/footer.html');
?>
