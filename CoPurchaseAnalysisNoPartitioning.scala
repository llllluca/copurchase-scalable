import org.apache.spark.SparkContext
import org.apache.spark.SparkConf
import org.apache.spark.HashPartitioner

object CoPurchaseAnalysisNoPartitioning {
    def main(args: Array[String]): Unit = {

        val configuration = new SparkConf().setAppName("CoPurchaseAnalysisNoPartitioning")
        val sc = new SparkContext(configuration)

        val inputPath = args(0)
        val outputPath = args(1)

        val orderIdProductIdPairs = sc.textFile(inputPath)
            .map(line => line.split(","))
            .map(array2 => (array2(0).toInt, array2(1).toInt))

        val prod1IdProd2IdCountTriples = orderIdProductIdPairs
          .groupByKey()
          .flatMap(p => 
              for {
                x <- p._2;
                y <- p._2 if x < y
              } yield ((x, y), 1)
          )

        val coPurchase = prod1IdProd2IdCountTriples.reduceByKey(_ + _)
            .map(p => s"${p._1._1},${p._1._2},${p._2}")

        coPurchase.repartition(1).saveAsTextFile(outputPath)

    }
}
