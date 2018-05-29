package dk.mathmagicians.watchman

object Main {
  def main(args: Array[String]): Unit = {
    println("Hello from watchman! I cant do to much yet")
    
    //read application configuration file
    val appConfig =  new ConfigComponent
    println( s"Loaded url from config file ${appConfig.url}" )
  }
}