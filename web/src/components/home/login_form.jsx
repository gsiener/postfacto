/*
 * Postfacto, a free, open-source and self-hosted retro tool aimed at helping
 * remote teams.
 *
 * Copyright (C) 2016 - Present Pivotal Software, Inc.
 *
 * This program is free software: you can redistribute it and/or modify
 *
 * it under the terms of the GNU Affero General Public License as
 *
 * published by the Free Software Foundation, either version 3 of the
 *
 * License, or (at your option) any later version.
 *
 *
 *
 * This program is distributed in the hope that it will be useful,
 *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *
 * GNU Affero General Public License for more details.
 *
 *
 *
 * You should have received a copy of the GNU Affero General Public License
 *
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

import React from 'react';
import types from 'prop-types';
import {GoogleLogin, GoogleOAuthProvider} from '@react-oauth/google';

// Decode JWT token to extract payload (user profile info)
function decodeJwt(token) {
  try {
    const base64Url = token.split('.')[1];
    const base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
    const jsonPayload = decodeURIComponent(
      atob(base64)
        .split('')
        .map((c) => '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2))
        .join(''),
    );
    return JSON.parse(jsonPayload);
  } catch (e) {
    return null;
  }
}

export default class LoginForm extends React.PureComponent {
  static propTypes = {
    onSuccess: types.func.isRequired,
    onFailure: types.func.isRequired,
    className: types.string.isRequired,
    config: types.shape({
      mock_google_auth: types.bool,
      google_oauth_client_id: types.string,
      google_oauth_hosted_domain: types.string,
    }).isRequired,
  };

  onMockLogin = (event) => {
    event.stopPropagation();

    const {onSuccess} = this.props;
    const accessToken = window.mock_google_auth; // this global is mutated during E2E tests

    const mockedEmail = accessToken.split('_')[1];
    onSuccess({
      profileObj: {
        email: mockedEmail + '@example.com',
        name: 'my full name',
      },
      accessToken,
    });
  };

  handleGoogleSuccess = (credentialResponse) => {
    const {onSuccess} = this.props;
    const credential = credentialResponse.credential;
    const decoded = decodeJwt(credential);

    if (decoded) {
      // Transform to match the expected format from the old library
      onSuccess({
        profileObj: {
          email: decoded.email,
          name: decoded.name,
        },
        accessToken: credential,
      });
    }
  };

  handleGoogleError = () => {
    const {onFailure} = this.props;
    onFailure();
  };

  render() {
    const {config} = this.props;

    if (!config.google_oauth_client_id && !config.mock_google_auth) {
      return null;
    }

    if (config.mock_google_auth) {
      return (
        <div onClickCapture={this.onMockLogin}>
          <button
            type="button"
            className={'button start-retro ' + this.props.className}
          >
            <span>
              <i className="fa fa-google" aria-hidden="true" style={{marginRight: '10px'}}/>
              Sign in with Google
            </span>
          </button>
        </div>
      );
    }

    return (
      <GoogleOAuthProvider clientId={config.google_oauth_client_id}>
        <GoogleLogin
          onSuccess={this.handleGoogleSuccess}
          onError={this.handleGoogleError}
          hosted_domain={config.google_oauth_hosted_domain}
        />
      </GoogleOAuthProvider>
    );
  }
}
