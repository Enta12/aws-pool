<template>
  <v-container>
    <v-layout wrap>
      <v-flex sm12 md6 offset-md3 style="justify-content: center">
        <v-card elevation="4" light tag="section">
          <v-card-title>
            <v-layout align-center justify-space-between>
              <h3 class="headline">
                {{ platformName }}
              </h3>
            </v-layout>
          </v-card-title>
          <v-divider></v-divider>
          <v-card-text>
            <p>Sign in with your username and email:</p>
            <v-form>
              <v-text-field
                  outline
                  label="Email"
                  type="email"
                  v-model="email"></v-text-field>
              <v-text-field
                  outline
                  hide-details
                  label="Password"
                  type="password"
                  v-model="password"></v-text-field>
            </v-form>
          </v-card-text>
          <v-divider></v-divider>
          <v-card-actions :class="{ 'pa-3': $vuetify.breakpoint.smAndUp }">
            <v-btn @click="SignUp" color="info" :large="$vuetify.breakpoint.smAndUp">
              Register
            </v-btn>
            <v-spacer></v-spacer>
            <v-btn @click="SignIn" :large="$vuetify.breakpoint.smAndUp" color="info">
              <v-icon left >mdi-lock</v-icon>
              Login
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
export default {
  data () {
    return {
      darkTheme: true,
      platformName: 'Time Clock',
      password: "",
      email: ""
    }
  },
  methods : {
     async SignIn() {
      console.log("password = ", this.password)
       let response = await fetch("http://ligne7.pepintrie.fr:4000/api/users/signIn",
           {
             method: 'POST',
             headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
         },
             body : JSON.stringify({email : this.email, password: this.password})}).then((res) => {
         return(res)
      }).catch((err) => {
        console.log(err)
      })
       if (response.status !== 200)
         return;
       response = await response.json()
       console.log(response)
       this.$store.commit('FillUserInfo', {id : response.user_id, username : response.username, email : this.email, role : response.role_id})
       this.$router.push("/")
     },
    SignUp() {

    }
  }
}
</script>

<style scoped>
.v-btn, .v-card {
  border-radius :4px
}
.v-card__title {
  text-transform: uppercase
}
</style>