import { ChevronLeft } from '../icons'
import RoundedInputField from '../components/RoundedInputField'
import PrimaryButton from '../components/PrimaryButton'

export default function EmailInputScreen({ state, update, onContinue, onBack }) {
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
        What's your email?
      </h1>

      {/* Input */}
      <div style={{ paddingLeft: 20, paddingRight: 20, paddingTop: 24 }}>
        <RoundedInputField
          placeholder="Email"
          value={state.email}
          onChange={(v) => update({ email: v })}
          type="email"
          autoFocus
        />
      </div>

      <div style={{ flex: 1 }} />

      {/* Button */}
      <div style={{ paddingLeft: 33, paddingRight: 33, paddingBottom: 24 }}>
        <PrimaryButton title="Continue" onClick={onContinue} />
      </div>
    </div>
  )
}
