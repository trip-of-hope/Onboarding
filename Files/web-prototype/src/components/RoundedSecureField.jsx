import { useState } from 'react'
import { EyeIcon } from '../icons'

export default function RoundedSecureField({ placeholder, value, onChange }) {
  const [visible, setVisible] = useState(false)

  return (
    <div style={{
      width: '100%',
      height: 56,
      paddingLeft: 20,
      paddingRight: 16,
      background: '#F2F2F7',
      borderRadius: 20,
      display: 'flex',
      alignItems: 'center',
      gap: 8,
      flexShrink: 0,
    }}>
      <input
        type={visible ? 'text' : 'password'}
        placeholder={placeholder}
        value={value}
        onChange={(e) => onChange(e.target.value)}
        autoComplete="new-password"
        style={{
          flex: 1,
          fontSize: 17,
          fontWeight: 500,
          color: 'black',
          background: 'transparent',
          minWidth: 0,
        }}
      />
      <button
        onClick={() => setVisible(v => !v)}
        style={{
          padding: 4,
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
          flexShrink: 0,
        }}
      >
        <EyeIcon off={!visible} />
      </button>
    </div>
  )
}
