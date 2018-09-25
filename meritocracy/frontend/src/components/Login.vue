<template>
  <div v-if="!isLoggedIn">
  	<h2> Please login </h2>
    <b-form  @submit.prevent="login">
 		<b-form-group id="login-group-1"
                    label="User Name"
                    label-for="emailInput"
                    description="We'll never share your email with anyone else.">
	        <b-form-input id="emailInput"
	                      type="text"
	                      v-model="username"
	                      required
	                      placeholder="Your username">
	        </b-form-input>
    	</b-form-group>
    	<b-form-group id="login-group-2"
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
    	<b-button type="submit" variant="success">Login</b-button>
    </b-form>
  </div>
  <div v-else>
  		You are logged in. {{token()}}
  </div>
</template>

<script>
	
	export default {
		name: 'login',
		data(){ 
			return {
				username: '', 
				password: '',
				isLoggedIn: false
			}
		},
		computed: {
			isLoggedIn(){
				return this.$store.getters.isLoggedIn;
			} 
		},
		methods: {
			login() {
		      this.$store.dispatch("login", {
		        email: this.email,
		        password: this.password
		      }).then(() => {
		        this.$router.push("/")
		      });
		      	console.log(this.username);
				console.log(this.password);
				console.log(this.isLoggedIn);
		    },
			token(){
				console.log(localStorage.getItem('token'));
			}
		}

	}

</script>