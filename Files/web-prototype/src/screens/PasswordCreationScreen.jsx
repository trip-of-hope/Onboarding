import { ChevronLeft } from '../icons'
import RoundedSecureField from '../components/RoundedSecureField'
import PrimaryButton from '../components/PrimaryButton'

export default function PasswordCreationScreen({ state, update, onCreateAccount, onBack }) {
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

      {/* Title */}
      <h1 style={{
        fontSize: 24,
        fontWeight: 600,
        textAlign: 'center',
        paddingLeft: 20,
        paddingRight: 20,
        paddingTop: 32,
        color: 'black',
        lineHeight: 1.3,
      }}>
        Set a password
      </h1>

      {/* Input */}
      <div style={{ paddingLeft: 20, paddingRight: 20, paddingTop: 24 }}>
        <RoundedSecureField
          placeholder="Password"
          value={state.password}
          onChange={(v) => update({ password: v })}
        />
      </div>

      {/* Hint */}
      <p style={{
        fontSize: 15,
        fontWeight: 400,
        color: 'rgba(60,60,67,0.6)',
        paddingLeft: 20,
        paddingRight: 20,
        paddingTop: 8,
      }}>
        6 characters minimum.
      </p>

      <div style={{ flex: 1 }} />

      {/* Button */}
      <div style={{ paddingLeft: 33, paddingRight: 33, paddingBottom: 24 }}>
        <PrimaryButton title="Create Account" onClick={onCreateAccount} />
      </div>
    </div>
  )
}
