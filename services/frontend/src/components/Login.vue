<template>
  <div v-if="!isLoggedIn">
  	 <b-form  
    	v-if="!logging"
    	@submit.prevent="login">
    	<h2> Please login </h2>
 		<b-form-group 
 			id="login-group-1"
            label="User Name"
            label-for="emailInput"
            description="We'll never share your email with anyone else.">
	        <b-form-input 
				id="emailInput"
				type="text"
				v-model="username"
				required
				placeholder="Your username">
	        </b-form-input>
    	</b-form-group>
    	<b-form-group 
    		id="login-group-2"
            label="Password"
            label-for="passwordInput"
            description="We'll never share your email with anyone else.">
	        <b-form-input id="passwordInput"
				type="password"
				v-model="password"
				required
				placeholder="Your password">
	        </b-form-input>
    	</b-form-group>
    	<b-button type="submit" variant="success">
    		Login with Github 	__^-^__
    	</b-button>
    </b-form>
    <b-alert 
          v-else
          show 
          variant="warning">
          Logging in, wait a moment please … 
      		<v-icon name="spinner" scale="3" spin/></v-icon>
      	</b-alert>
  </div>
  <div v-else>
  		You are logged in, {{token.name}}
  </div>
</template>

<script>
	
	export default {
		name: 'login',
		data(){ 
			return {
				username: '', 
				password: '',
				logging: false
			}
		},
		computed: {
			isLoggedIn(){
				return this.$store.getters.isLoggedIn;
			} 
		},
		methods: {
			login() {
				this.logging = true;
				this.$store
					.dispatch("login", {username: this.username, password: this.password})
					.then(() => {
						this.logging=false
						this.$router.go(-1)
					})
					.catch((error) => {
				        console.log(error)
				        this.$router.push( {name: 'error'})
				     })
		    },
			token(){
				return localStorage.getItem('token')
			}
		}

	}

</script>