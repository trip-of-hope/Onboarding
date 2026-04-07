import { Checkmark } from '../icons'

export default function OptionRow({ title, isSelected, onClick }) {
  return (
    <button
      onClick={onClick}
      style={{
        width: '100%',
        height: 64,
        background: '#F2F2F7',
        borderRadius: 20,
        padding: '0 20px',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'space-between',
        gap: 12,
        position: 'relative',
        flexShrink: 0,
        outline: 'none',
      }}
    >
      {/* Selection border overlay */}
      {isSelected && (
        <div style={{
          position: 'absolute',
          inset: 0,
          borderRadius: 20,
          border: '1.5px solid black',
          pointerEvents: 'none',
        }} />
      )}

      <span style={{
        fontSize: 17,
        fontWeight: 500,
        color: 'black',
        textAlign: 'left',
        flex: 1,
        letterSpacing: '-0.1px',
      }}>
        {title}
      </span>

      <div style={{
        width: 24,
        height: 24,
        borderRadius: 8,
        background: isSelected ? 'black' : 'white',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        flexShrink: 0,
        transition: 'background 0.15s',
      }}>
        {isSelected && <Checkmark />}
      </div>
    </button>
  )
}
