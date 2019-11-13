import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Redirect } from 'react-router-dom';
import { translate } from 'react-i18next';
import { Loader } from 'semantic-ui-react';
import { get as _get } from 'lodash';

import setProfileSchema from 'utils/schemas/setProfile';
import setProfileShape from 'utils/shapes/setProfileShape';
import { get } from 'utils/api';
import FooForm from 'components/Common/FooForm';
import LanguagePickerContainer from 'components/Common/LanguagePickerContainer';
import LogoFull from 'components/icons/LogoFull';

export class SetProfile extends Component {
  state = { userExists: undefined };

  componentDidMount() {
    get('/users/user')
      .then(() => {
        this.setState({ userExists: true });
      })
      .catch((error) => {
        const errorCode = _get(error, 'response.data.errors[0].code', null);
        if (errorCode === 'user_not_found') {
          this.setState({ userExists: false });
        } else {
          this.setState({ userExists: true });
        }
      });
  }

  setProfile = (id, info) => {
    this.props.setUserProfile(info);
  }

  render() {
    const { userExists } = this.state;
    const { t, user } = this.props;
    const { validation, isSetProfilePending, isRegisterSuccesful } = user;
    const { isError, message, translationKey } = validation;
    const errorMessage = translationKey ? t(`backend.${translationKey}`) : message;

    if (typeof userExists === 'undefined') {
      return <Loader size="small" active inline="centered" className="fetcher-loader" />;
    } if (userExists || isRegisterSuccesful) {
      return <Redirect to="/overview" />;
    }
    return (
      <div className="login">
        <div className="login__image" />
        <div className="login__content">
          <LogoFull className="login__logo" />
          <div className="login__header">
            {t('setProfile.title')}
          </div>
          <div className="login__description">
            {t('setProfile.description')}
          </div>
          <FooForm
            className="login__form"
            externalMessage={{ isError, messages: message.length > 1 ? [errorMessage] : [] }}
            onSubmitAction={this.setProfile}
            isPending={isSetProfilePending}
            schema={setProfileSchema}
            shape={setProfileShape}
            btnText={t('setProfile.register')}
          />
          <div className="login__language-picker">
            <LanguagePickerContainer />
          </div>
        </div>
      </div>
    );
  }
}

SetProfile.propTypes = {
  t: PropTypes.func.isRequired,
  setUserProfile: PropTypes.func.isRequired,
  user: PropTypes.shape({}).isRequired,
};

export default translate()(SetProfile);
