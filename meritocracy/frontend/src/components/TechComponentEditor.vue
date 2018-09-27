<template>
	<div>
		<b-alert
			v-if="!isEditOn" 
			show
			variant="danger">
			<v-icon name="times" scale="2">
			</v-icon>
			You must be logged in, and enable editing, before you can proceed.
		</b-alert>
		<b-card v-else>
			<b-card-header>
				Edit Technology: 
				<strong>{{techModel.name}}</strong> 
				<life-cycle :status="techModel.status"></life-cycle>
			</b-card-header>
			<b-card-body>
				<b-form @submit="onSubmit" @reset="onReset">
					<b-form-group id="exampleInputGroup1"
						label="Email address:"
						label-for="exampleInput1"
						description="We'll never share your email with anyone else.">
						<b-form-input id="exampleInput1"
						type="email"
						v-model="techModel.name"
						required
						placeholder="Enter email">
						</b-form-input>
					</b-form-group>
					<b-button type="submit" variant="success">Save</b-button>
					<b-button type="reset" variant="outline-secondary">Cancel</b-button>
				</b-form>
				<b-row>
				</b-row>
			</b-card-body>
		</b-card>
	</div>
</template>

<script>
	import LifeCycle from '../components/LifeCycle.vue'

	export default {
		name: "techComponentEditor",
		components: {LifeCycle},
		data(){
			return {
				techModel: {
					uid: '',
					name: '',
					status: '',
					description: '',
					comments: [],
					tax: [],
					licenses: [],
					links: [],
					usecases: [],
					log: []
				},
				usecaseModel: {
					name: '',
					description: '',
					status: '',
					scope: ''
				},
				logModel: {
					date: '',
					description: '',
					status: ''
				}
			}
		},
		computed: {
			isEditOn() {
        		return this.$store.getters.isEditOn;
      		}
		},
		methods: {
			onSubmit(){
				console.log("todo submit");
			},
			onReset(){
				console.log("todo reset");
			}
		}
	}

</script>