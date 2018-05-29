package dk.mathmagicians.watchman

import com.typesafe.config.ConfigFactory

 
  class ConfigComponent {
    private val config = ConfigFactory.load()
    val url = config.getString("confluence.url")
    
  }