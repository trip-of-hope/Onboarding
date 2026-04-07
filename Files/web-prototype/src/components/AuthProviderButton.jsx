import { AppleLogo } from '../icons'
import googleLogo from '../assets/google-logo.svg'

export default function AuthProviderButton({ title, icon = 'none', style = 'primary', onClick }) {
  const renderIcon = () => {
    if (icon === 'apple') return <AppleLogo color={style === 'primary' ? 'white' : 'black'} size={17} />
    if (icon === 'google') return <img src={googleLogo} width={20} height={20} alt="Google" />
    return null
  }

  if (style === 'primary') {
    return (
      <button
        onClick={onClick}
        style={{
          width: '100%',
          height: 56,
          background: 'black',
          borderRadius: 9999,
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
          gap: 8,
          flexShrink: 0,
        }}
      >
        {renderIcon()}
        <span style={{ fontSize: 17, fontWeight: 600, color: 'white', letterSpacing: '-0.2px' }}>
          {title}
        </span>
      </button>
    )
  }

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
        gap: 8,
        flexShrink: 0,
      }}
    >
      {renderIcon()}
      <span style={{ fontSize: 17, fontWeight: 600, color: 'black', letterSpacing: '-0.2px' }}>
        {title}
      </span>
    </button>
  )
}
