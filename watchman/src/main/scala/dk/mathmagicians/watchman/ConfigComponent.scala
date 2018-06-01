package dk.mathmagicians.watchman

import com.typesafe.config.ConfigFactory

 
  class ConfigComponent {
    private val config = ConfigFactory.load()
    val confluence = Confluence(  user = config.getString( "confluence.user.mail"), 
          password = config.getString("confluence.user.password"),
          endpoint = config.getString("confluence.url"))
    
    case class Confluence( user:String, password: String, endpoint: String)
    
  }