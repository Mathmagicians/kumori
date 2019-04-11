import auth0 from 'auth0-js'

export default class AuthService {
  auth0 = new auth0.WebAuth({
    domain: 'mindfield.eu.auth0.com',
    clientID: 'QERGzVzudxY25M3TOa5rmcwVW8yWbzyg',
    redirectUri: 'http://127.0.0.1/components',
    responseType: 'token id_token',
    scope: 'openid'
  })

  login () {
    this.auth0.authorize()
  }
}
