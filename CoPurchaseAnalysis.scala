import org.apache.spark.SparkContext
import org.apache.spark.SparkConf

object CoPurchaseAnalysis {
    def main(args: Array[String]): Unit = {

        val configuration = new SparkConf().setAppName("CoPurchaseAnalysis")
        val sc = new SparkContext(configuration)

        val inputPath = args(0)
        val outputPath = args(1)

        val input = sc.textFile(inputPath)
            .map(line => line.split(","))
            .map(array2 => (array2(0).toInt, array2(1).toInt))

        val sameOrderProducs = input.groupByKey()
            .flatMap(p => for (x <- p._2; y <- p._2; if x < y) yield ((x, y), 1))

        val coPurchase = sameOrderProducs.reduceByKey(_ + _)
            .map(p => s"${p._1._1}, ${p._1._2}, ${p._2}")

        coPurchase.saveAsTextFile(outputPath)

    }
}
