import org.apache.spark.SparkContext
import org.apache.spark.SparkConf
import org.apache.spark.api.java.JavaSparkContext

object Hello {
  def main(a: Array[String]): Unit = {

    val configuration = new SparkConf().setAppName("Hello")
    val sc = new JavaSparkContext(configuration)

    val NUM_SAMPLES = 1000000
    val count = sc.parallelize(1 to NUM_SAMPLES).map { i =>
      val x = Math.random()
      val y = Math.random()
      if (x * x + y * y < 1) 1 else 0
    }.reduce(_ + _)
    println("def ==> Pi is roughly " + 4.0 * count / NUM_SAMPLES)
  }
}
