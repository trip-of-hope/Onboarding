import logoName from '../assets/logo-name.svg'
import { ChevronLeft } from '../icons'
import CheckboxRow from '../components/CheckboxRow'
import PrimaryButton from '../components/PrimaryButton'
import SecondaryButton from '../components/SecondaryButton'

export default function PrivacyConsentScreen({ state, update, onContinue, onBack }) {
  const bothChecked = state.privacyConsent1 && state.privacyConsent2

  return (
    <div style={{
      flex: 1,
      display: 'flex',
      flexDirection: 'column',
      background: 'white',
    }}>
      {/* Toolbar */}
      <div className="toolbar">
        <button className="toolbar-back" onClick={onBack}>
          <ChevronLeft />
        </button>
      </div>

      {/* Logo wordmark */}
      <div style={{ display: 'flex', justifyContent: 'center', paddingTop: 8 }}>
        <img src={logoName} alt="Motra" style={{ height: 20 }} />
      </div>

      {/* Title + subtitle */}
      <div style={{
        paddingTop: 48,
        paddingLeft: 40,
        paddingRight: 40,
        display: 'flex',
        flexDirection: 'column',
        gap: 16,
        alignItems: 'center',
      }}>
        <h1 style={{
          fontSize: 24,
          fontWeight: 600,
          textAlign: 'center',
          color: 'black',
          lineHeight: 1.3,
        }}>
          We value your privacy.
        </h1>
        <p style={{
          fontSize: 15,
          fontWeight: 400,
          textAlign: 'center',
          color: 'black',
          lineHeight: 1.5,
        }}>
          Your data is serious business.{'\n'}We never share or sell your data with third parties.
        </p>
      </div>

      <div style={{ flex: 1 }} />

      {/* Checkboxes */}
      <div style={{
        paddingLeft: 33,
        paddingRight: 33,
        display: 'flex',
        flexDirection: 'column',
        gap: 24,
      }}>
        <CheckboxRow
          checked={state.privacyConsent1}
          onChange={(v) => update({ privacyConsent1: v })}
        >
          I understand that my data may be used to generate personalized insights and recommendations.
        </CheckboxRow>

        <CheckboxRow
          checked={state.privacyConsent2}
          onChange={(v) => update({ privacyConsent2: v })}
        >
          I agree to Motra's{' '}
          <strong>Terms of Service</strong> and{' '}
          <strong>Privacy Policy.</strong>
        </CheckboxRow>
      </div>

      <div style={{ height: 32 }} />

      {/* Buttons */}
      <div style={{
        paddingLeft: 33,
        paddingRight: 33,
        paddingBottom: 24,
        display: 'flex',
        flexDirection: 'column',
        gap: 12,
      }}>
        <SecondaryButton
          title="Accept All"
          onClick={() => update({ privacyConsent1: true, privacyConsent2: true })}
        />
        <PrimaryButton
          title="Continue"
          onClick={onContinue}
          disabled={!bothChecked}
        />
      </div>
    </div>
  )
}
