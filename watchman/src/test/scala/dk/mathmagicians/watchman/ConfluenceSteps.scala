package dk.mathmagicians.watchman

import cucumber.api.scala.{ EN, ScalaDsl }
import cucumber.api.PendingException
import org.scalatest._


class ConfluenceSteps extends ScalaDsl with EN with Matchers{
  
  @throws(classOf[java.io.IOException])
  def get(url: String) = scala.io.Source.fromURL(url).mkString
  
  Given("""^I have a Confluence endpoint$"""){ () =>
  
  val confluenceEndpoint:String = (new ConfigComponent).url
  confluenceEndpoint should not be (null)
  confluenceEndpoint should include ("integration")
  get( confluenceEndpoint) should not be (null)
  println (get(confluenceEndpoint))
  
  
}
  
  
}




