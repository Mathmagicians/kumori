import Taxonomy from "@/api/Taxonomy";
const state = {
  list: [],
  selectOptions: [],
  selected: [],
  error: undefined
}

const getters = {
  list: state => state.list,
  selectOptions: state => state.selectOptions,
  selected: state => state.selected
}

const actions = {
  list({
    commit,
    state
  }) {
    if (state.list.length === 0) {
      new Taxonomy().list()
        .then(response => {
          commit('setList', response)
          commit('setSelectOptions', response.map(entry => {
            return {
              text: entry.name,
              value: entry.id
            }
          }))
        })
        .catch(error => {
          commit('setError', error)
        });
    }
  }
}

const mutations = {
  setList(state, list) {
    state.list = list;
  },
  setSelected(state, selected) {
    state.selected = selected;
  },
  setSelectOptions(state, list) {
    state.selectOptions = list;
  },
  setError(state, error) {
    state.error = error;
  }
}

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}
