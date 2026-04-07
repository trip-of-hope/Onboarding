import { useState, useEffect } from 'react'

export default function PlanLoadingScreen({ onComplete }) {
  const [showSecond, setShowSecond] = useState(false)

  useEffect(() => {
    const t1 = setTimeout(() => setShowSecond(true), 3500)
    const t2 = setTimeout(() => onComplete(), 7000)
    return () => { clearTimeout(t1); clearTimeout(t2) }
  }, [onComplete])

  return (
    <div style={{
      flex: 1,
      display: 'flex',
      flexDirection: 'column',
      alignItems: 'center',
      justifyContent: 'center',
      gap: 32,
      background: 'white',
    }}>
      {/* Spinner */}
      <div style={{
        width: 36,
        height: 36,
        borderRadius: '50%',
        border: '3px solid rgba(0,0,0,0.12)',
        borderTopColor: 'black',
        animation: 'spin 0.8s linear infinite',
        transform: 'scale(1.3)',
      }} />

      {/* Messages */}
      <div style={{ position: 'relative', height: 32 }}>
        <p style={{
          fontSize: 21,
          fontWeight: 600,
          textAlign: 'center',
          color: 'black',
          position: 'absolute',
          width: '300px',
          left: '50%',
          transform: 'translateX(-50%)',
          opacity: showSecond ? 0 : 1,
          transition: 'opacity 0.6s ease-in-out',
          whiteSpace: 'nowrap',
        }}>
          Getting ready your plan...
        </p>
        <p style={{
          fontSize: 21,
          fontWeight: 600,
          textAlign: 'center',
          color: 'black',
          position: 'absolute',
          width: '300px',
          left: '50%',
          transform: 'translateX(-50%)',
          opacity: showSecond ? 1 : 0,
          transition: 'opacity 0.6s ease-in-out',
          whiteSpace: 'nowrap',
        }}>
          Personalizing your experience...
        </p>
      </div>

    </div>
  )
}
