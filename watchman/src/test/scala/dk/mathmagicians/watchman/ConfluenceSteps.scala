package dk.mathmagicians.watchman

import cucumber.api.scala.{ EN, ScalaDsl }
import cucumber.api.PendingException
import org.scalatest._


class ConfluenceSteps extends ScalaDsl with EN with Matchers{
  
  @throws(classOf[java.io.IOException])
  def get(url: String) = scala.io.Source.fromURL(url)
  
  Given("""^I have a Confluence endpoint$"""){ () =>
  
  val confluenceEndpoint:String = (new ConfigComponent).confluence.endpoint
  confluenceEndpoint should not be (null)
  confluenceEndpoint should include ("integration")
  
  val restGET =   get( confluenceEndpoint)
  restGET should not be (null)
  
  
}
  
  
}




