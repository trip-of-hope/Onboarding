export default function SecondaryButton({ title, onClick }) {
  return (
    <button
      onClick={onClick}
      style={{
        width: '100%',
        height: 56,
        background: 'rgba(116, 116, 128, 0.12)',
        backdropFilter: 'blur(20px)',
        WebkitBackdropFilter: 'blur(20px)',
        borderRadius: 9999,
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        flexShrink: 0,
      }}
    >
      <span style={{
        fontSize: 17,
        fontWeight: 600,
        color: 'black',
        letterSpacing: '-0.2px',
      }}>
        {title}
      </span>
    </button>
  )
}
