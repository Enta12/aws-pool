<template>
    <v-container fill-height fluid align="center" class="justify-center">
      <v-row justify="center">
        <v-sheet align="center" color="white" elevation="5" height="30%" width="30%">
          <v-col >
            <p>{{this.$store.state.user.isLoggedIn === false ? "Veuillez vous connecter" : "Bonjour " + this.$store.state.user.username}}</p>
            <v-btn style="margin: 10px" v-on:click="Redirect">{{this.$store.state.user.isLoggedIn === false ? "Se connecter" : "Aller sur votre page utilisateur"}}</v-btn>
            <v-btn style="margin: 10px" v-if="this.$store.state.user.isLoggedIn" v-on:click="Disconnexion"> Déconnexion </v-btn>
            <v-btn style="margin: 10px" v-if="this.$store.state.user.isLoggedIn" v-on:click="Pointer"> Pointer </v-btn>
            <v-btn style="margin: 10px" v-if="this.$store.state.user.isLoggedIn" v-on:click="GetRemainingTime"> GetRemainingTime </v-btn>
          </v-col>
        </v-sheet>
      </v-row>
      <v-row justify="center" v-if="this.$store.state.user.isConnected === true">
        <v-sheet align="center" color="white" elevation="5" height="30%" width="30%">
          <p>Vous êtes présent</p>
          <v-progress-circular
              :rotate="180"
              :size="100"
              :width="15"
              :value="10"
              color="red"
          >
            {{ 10 }}
          </v-progress-circular>
        </v-sheet>
      </v-row>
    </v-container>
</template>

<script>
import {getDateTime} from "../storeUtils/StoreUtils";

export default {
  name: "Home",
  components : {
  },
  data () {
    return {
      knowledge : 33,
      remaining_time : "",
      pourcentage : 0
    }
  },
  mounted() {
    let test = {clock: {time: "", status: false}}
    if (this.$store.state.user.isConnected) {
      fetch("http://localhost:4000/api/clocks/" + this.$store.state.user.id, {
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        method: 'POST',
        body: JSON.stringify(test)
      })
          .then((response) => {
            console.log(response.json())
          }).catch((err) => {
        console.log("MY ERROR = ", err)
      })
    }
  },
  methods: {
    GetRemainingTime() {
    },
    Pointer() {
      let date = getDateTime()
      if (this.$store.state.user.isConnected === false)
      {
        this.$store.commit('SetPointingDate', {date_str :date.date_str, date : date.date})
        let test = {clock: {time: date.date_str, status: false}}
          fetch("http://localhost:4000/api/clocks/" + this.$store.state.user.id, {
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json'
            },
            method: 'PUT',
            body: JSON.stringify(test)
          })
              .then((response) => {
                console.log(response.json())
              }).catch((err) => {
            console.log("MY ERROR = ", err)
          })
        this.$store.commit("pointer")
      }
      else {
        this.$store.commit("pointer")
      }
    },
    Redirect() {
      if (this.$store.state.user.isLoggedIn === true) {
        this.$router.push("/User")
      } else {
        this.$router.push("/Login")
      }
    },
    Disconnexion() {
      this.$store.commit("DisconnectUser")
      this.$router.push("/Login")

    }
  }
}
</script>

<style scoped>
.rowmargin {
}
.sheetstyle {
  width: 40%;
  height: 150px;
  margin: 50px;
}


</style>