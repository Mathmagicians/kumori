<template>

	 <div id="home">
    <p id="techmenu-welcome">
       Based on principles of idea meritocracy, we aim to make rational technology decisions. 
       The decisions are recorded in a catalog of technologies -- the #techmenu.
      </p>
    <b-jumbotron>
      <template slot="header">
        Welcome to #techmenu
      </template>
      <template slot="lead">
        #techmenu is a community, a process and a catalog of technologies.
      </template>
      <b-carousel id="carousel1"
                style="text-shadow: 1px 1px 2px #333;"
                controls
                indicators
                background="#aaaaaa"
                :interval="4000"
                img-width="1024"
                img-height="480">
        <b-carousel-slide 
          caption="It is a community"
          text="Based on principles of idea meritocracy, we aim to make rational technology decisions."
          img-src="../assets/community.svg"
        >
         
        </b-carousel-slide>
      </b-carousel>

      <b-btn 
        variant="link lg" to="/components">Checkout the #techmenu...</b-btn>
      <b-btn variant="link lg" to="/about">Explain more...</b-btn>
    </b-jumbotron>  

  </div>
</template>

<script>


  export default {
  	name: 'home',

  }

}

</script>
