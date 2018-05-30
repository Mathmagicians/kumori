package dk.mathmagicians.watchman

import cucumber.api.scala.{EN, ScalaDsl}

class ShoppingSteps extends ScalaDsl with EN {
  
  val shoppingItems = Nil

 
  Before() { _ =>
      println( "Before")
  }

  Given("""^a user is registered with the store$"""){ () =>
    println( "Given")
  }

  When("""^the user buys(?: the| another) (book|food item|chocolates) of (.+) rupees$"""){ (item: String, amount: Double) =>
    println( "When")
  }
 
}
