import { Checkmark } from '../icons'

export default function CheckboxRow({ checked, onChange, children }) {
  return (
    <div style={{
      display: 'flex',
      alignItems: 'flex-start',
      gap: 14,
    }}>
      <button
        onClick={() => onChange(!checked)}
        style={{
          width: 24,
          height: 24,
          borderRadius: 8,
          background: checked ? 'black' : '#F2F2F7',
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
          flexShrink: 0,
          marginTop: 1,
          transition: 'background 0.15s',
        }}
      >
        {checked && <Checkmark />}
      </button>
      <div style={{ flex: 1, fontSize: 15, lineHeight: 1.4, color: 'black' }}>
        {children}
      </div>
    </div>
  )
}
