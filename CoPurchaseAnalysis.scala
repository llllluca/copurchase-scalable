import org.apache.spark.SparkContext
import org.apache.spark.SparkConf
import org.apache.spark.HashPartitioner

object CoPurchaseAnalysis {
    def main(args: Array[String]): Unit = {

        val configuration = new SparkConf().setAppName("CoPurchaseAnalysis")
        val sc = new SparkContext(configuration)

        val partitionsNumber = args(0).toInt
        val inputPath = args(1)
        val outputPath = args(2)

        val orderIdProductIdPairs = sc.textFile(inputPath)
            .map(line => line.split(","))
            .map(array2 => (array2(0).toInt, array2(1).toInt))

        //https://engineering.salesforce.com/how-to-optimize-your-apache-spark-application-with-partitions-257f2c1bb414/
        val prod1IdProd2IdCountTriples = orderIdProductIdPairs
          .partitionBy(new HashPartitioner(partitionsNumber))
          .groupByKey()
          .flatMap(p => for (x <- p._2; y <- p._2; if x < y) yield ((x, y), 1))

        val coPurchase = prod1IdProd2IdCountTriples.reduceByKey(_ + _)
            .map(p => s"${p._1._1},${p._1._2},${p._2}")

        coPurchase.saveAsTextFile(outputPath)

    }
}
