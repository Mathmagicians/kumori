const state = {
  authenticated: localStorage.getItem('token') !== null ? true : false,
  readonly: true,
  token: localStorage.getItem('token')
}

const getters = {
  authenticated: state => state.authenticated,
  readonly: state => state.readonly
}

const mutations = {
  login(state) {
    state.authenticated = true;
  },
  logout(state) {
    state.authenticated = false;
  },
  crud(state) {
    state.readonly = false;
  },
  read(state) {
    state.readonly = true;
  },
  setToken(state, token) {
    state.token = token;
  }
}

const actions = {
  login({
    commit
  }, credentials) {
    let token = ['eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9', 'eyJyb2xlIjoiZWRpdG9yIn0', 'tYUlheVyisdr0ezFYf92mC_dvSS02cpDvPBu9aKLySk']
    localStorage.setItem("token", token.join('.'));
    commit('login')
    commit('setToken', token.join('.'))
  },
  logout({
    commit
  }) {
    localStorage.removeItem("token");
    commit('logout')
  },
  crud({
    commit
  }) {
    commit('crud')
  },
  read({
    commit
  }) {
    commit('read')
  },
}

export default {
  state,
  getters,
  actions,
  mutations
}
