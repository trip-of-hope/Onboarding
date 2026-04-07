import logoFull from '../assets/logo-full.svg'
import PrimaryButton from '../components/PrimaryButton'

export default function SplashScreen({ onGetStarted }) {
  return (
    <div style={{
      flex: 1,
      display: 'flex',
      flexDirection: 'column',
      background: 'white',
      paddingBottom: 24,
    }}>
      {/* Spacer before logo (1 part) */}
      <div style={{ flex: 1 }} />

      {/* Logo */}
      <div style={{ display: 'flex', justifyContent: 'center' }}>
        <img src={logoFull} alt="Motra" style={{ width: 160 }} />
      </div>

      {/* 2 spacers after logo push it toward upper third */}
      <div style={{ flex: 2 }} />

      {/* Bottom content block */}
      <div>
        <p style={{
          fontSize: 24,
          fontWeight: 500,
          textAlign: 'center',
          paddingLeft: 33,
          paddingRight: 33,
          color: 'black',
          lineHeight: 1.3,
        }}>
          AI coaching for the real world.
        </p>

        <div style={{ height: 28 }} />

        <div style={{ paddingLeft: 33, paddingRight: 33 }}>
          <PrimaryButton title="Get Started" onClick={onGetStarted} />
        </div>

        <div style={{ height: 32 }} />

        <div style={{ display: 'flex', justifyContent: 'center' }}>
          <button style={{ fontSize: 17, color: 'black' }}>
            <span style={{ fontWeight: 400 }}>Already have an account? </span>
            <span style={{ fontWeight: 600 }}>Log in</span>
          </button>
        </div>
      </div>
    </div>
  )
}
