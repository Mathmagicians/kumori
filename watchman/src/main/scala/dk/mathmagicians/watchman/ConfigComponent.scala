package dk.mathmagicians.watchman

import com.typesafe.config.ConfigFactory

 
  class ConfigComponent {
    private val config = ConfigFactory.load()
    val url:String = config.getString("confluence.url")
    
  }