import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

const store = new Vuex.Store({
    state: {
        count: 0,
        showSideBar: false,
        user : {
            isLoggedIn: false,
            imgAvatar: "",
            username : "",
            isConnected : false,
            email : "",
            id : -1,
            PointingDate : {},
            TimeElapsed : "",
            role : 0
        }
    },
    mutations: {
        pointer (state) {
            state.user.isConnected = !state.user.isConnected
        },
        increment (state) {
            state.count++
        },
        changestate (state) {
            state.showSideBar = true
        },
        FillUserInfo(state, param) {
            console.log(param)
            state.user.id = param.id
            state.user.username = param.username
            state.user.email = param.email
            state.user.isLoggedIn = true
            state.user.role = param.role
        },
        DisconnectUser(state) {
            state.user.id = -1
            state.user.username = ""
            state.user.email = ""
            state.user.isConnected = false
            state.user.isLoggedIn = false
            state.user.imgAvatar = ""
            state.user.PointingDate = {}
        },
        SetPointingDate(state, param) {
            state.user.PointingDate = {date_str: param.date_str, date : param.date_str}
        }
    }
})

export default store;