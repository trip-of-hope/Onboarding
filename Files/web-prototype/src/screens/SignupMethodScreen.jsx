import logoName from '../assets/logo-name.svg'
import { ChevronLeft } from '../icons'
import AuthProviderButton from '../components/AuthProviderButton'

export default function SignupMethodScreen({ onContinueWithEmail, onBack }) {
  return (
    <div style={{
      flex: 1,
      display: 'flex',
      flexDirection: 'column',
      background: 'white',
      paddingLeft: 33,
      paddingRight: 33,
    }}>
      {/* Toolbar */}
      <div className="toolbar" style={{ paddingLeft: 0, paddingRight: 0 }}>
        <button className="toolbar-back" onClick={onBack}>
          <ChevronLeft />
        </button>
      </div>

      {/* Logo + headline */}
      <div style={{
        paddingTop: 8,
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        gap: 32,
      }}>
        <img src={logoName} alt="Motra" style={{ height: 20 }} />
        <h1 style={{
          fontSize: 24,
          fontWeight: 500,
          color: 'black',
          textAlign: 'center',
        }}>
          Let's get started.
        </h1>
      </div>

      <div style={{ flex: 1 }} />

      {/* Auth buttons */}
      <div style={{ display: 'flex', flexDirection: 'column', gap: 12 }}>
        <AuthProviderButton
          title="Continue with Apple"
          icon="apple"
          style="primary"
          onClick={() => {}}
        />
        <AuthProviderButton
          title="Continue with Google"
          icon="google"
          style="secondary"
          onClick={() => {}}
        />
      </div>

      {/* Ghost button */}
      <div style={{ height: 32 }} />

      <div style={{ display: 'flex', justifyContent: 'center' }}>
        <button
          onClick={onContinueWithEmail}
          style={{
            fontSize: 17,
            fontWeight: 600,
            color: 'black',
            opacity: 0.4,
          }}
        >
          Continue with Email
        </button>
      </div>

      <div style={{ height: 24 }} />
    </div>
  )
}
