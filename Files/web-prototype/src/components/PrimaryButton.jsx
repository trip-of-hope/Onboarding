export default function PrimaryButton({ title, onClick, disabled = false }) {
  return (
    <button
      onClick={disabled ? undefined : onClick}
      style={{
        width: '100%',
        height: 56,
        background: disabled ? 'black' : 'black',
        borderRadius: 9999,
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        opacity: disabled ? 0.35 : 1,
        transition: 'opacity 0.2s ease-in-out',
        cursor: disabled ? 'default' : 'pointer',
        flexShrink: 0,
      }}
    >
      <span style={{
        fontSize: 17,
        fontWeight: 600,
        color: 'white',
        letterSpacing: '-0.2px',
      }}>
        {title}
      </span>
    </button>
  )
}
