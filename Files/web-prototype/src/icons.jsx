// Icon components replacing SF Symbols used in the iOS app

export function ChevronLeft({ size = 17 }) {
  const s = size * 0.65
  return (
    <svg width={s} height={s * 1.6} viewBox="0 0 11 18" fill="none">
      <path
        d="M9 1.5L1.5 9L9 16.5"
        stroke="black"
        strokeWidth="2.5"
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </svg>
  )
}

export function Checkmark({ color = 'white', size = 11 }) {
  return (
    <svg width={size} height={size * 0.8} viewBox="0 0 11 9" fill="none">
      <path
        d="M1 4.5L4 7.5L10 1.5"
        stroke={color}
        strokeWidth="2"
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </svg>
  )
}

export function EyeIcon({ off = false, color = 'rgba(60,60,67,0.6)' }) {
  if (off) {
    return (
      <svg width="22" height="18" viewBox="0 0 22 18" fill="none">
        <path
          d="M1 1L21 17M9.2 4.5A6 6 0 0 1 11 4C15.5 4 19 8.5 19 9C19 9.4 18.2 10.8 16.7 12.2M13 13.9A6 6 0 0 1 11 14C6.5 14 3 9.5 3 9C3 8.6 3.8 7.2 5.3 5.8"
          stroke={color}
          strokeWidth="1.8"
          strokeLinecap="round"
        />
      </svg>
    )
  }
  return (
    <svg width="22" height="16" viewBox="0 0 22 16" fill="none">
      <path
        d="M11 1C6.5 1 3 5.5 3 8C3 10.5 6.5 15 11 15C15.5 15 19 10.5 19 8C19 5.5 15.5 1 11 1Z"
        stroke={color}
        strokeWidth="1.8"
      />
      <circle cx="11" cy="8" r="3" stroke={color} strokeWidth="1.8" />
    </svg>
  )
}

export function AppleLogo({ color = 'white', size = 17 }) {
  return (
    <svg width={size * 0.83} height={size} viewBox="0 0 14 17" fill="none">
      <path
        d="M13.4 12.6C13.1 13.3 12.7 13.9 12.2 14.5C11.5 15.3 10.9 15.8 10.2 16C9.5 16.2 8.7 16 7.9 15.5C7.1 15 6.3 15 5.5 15.5C4.7 16 3.9 16.2 3.2 16C2.5 15.8 1.9 15.3 1.2 14.4C0.5 13.5 0 12.5 -0.1 11.3C-0.1 9.9 0.3 8.7 1 7.8C1.6 7 2.4 6.6 3.4 6.6C3.9 6.6 4.6 6.8 5.4 7.1C6.2 7.4 6.7 7.6 6.9 7.6C7.1 7.6 7.6 7.4 8.5 7C9.4 6.7 10.1 6.5 10.7 6.6C12.3 6.7 13.4 7.4 14 8.7C12.7 9.5 12 10.5 12.1 11.7C12.1 12.6 12.5 13.4 13.4 12.6Z"
        fill={color}
      />
      <path
        d="M10.7 1C10.7 1.7 10.5 2.4 10 3C9.5 3.6 8.8 4 8 3.9C7.9 3.2 8.2 2.5 8.7 1.9C9.2 1.3 9.9 0.9 10.7 1Z"
        fill={color}
      />
    </svg>
  )
}

export function HeartFill({ size = 40, opacity = 0.2 }) {
  return (
    <svg width={size} height={size * 0.9} viewBox="0 0 44 40" fill="none" style={{ opacity }}>
      <path
        d="M22 38C22 38 4 26 4 14C4 8.5 8.5 4 14 4C17.2 4 20 5.6 22 8C24 5.6 26.8 4 30 4C35.5 4 40 8.5 40 14C40 26 22 38 22 38Z"
        fill="black"
      />
    </svg>
  )
}

export function BellFill({ size = 40, opacity = 0.2 }) {
  return (
    <svg width={size} height={size} viewBox="0 0 44 44" fill="none" style={{ opacity }}>
      <path
        d="M22 6C22 6 12 8 12 20V30H32V20C32 8 22 6 22 6Z"
        fill="black"
      />
      <path
        d="M18 30C18 32.2 19.8 34 22 34C24.2 34 26 32.2 26 30H18Z"
        fill="black"
      />
      <rect x="20" y="4" width="4" height="4" rx="2" fill="black" />
    </svg>
  )
}

export function DumbbellFill({ size = 40, opacity = 0.2 }) {
  return (
    <svg width={size} height={size * 0.5} viewBox="0 0 44 22" fill="none" style={{ opacity }}>
      <rect x="2" y="8" width="6" height="6" rx="2" fill="black" />
      <rect x="2" y="4" width="6" height="14" rx="3" fill="black" />
      <rect x="36" y="8" width="6" height="6" rx="2" fill="black" />
      <rect x="36" y="4" width="6" height="14" rx="3" fill="black" />
      <rect x="8" y="10" width="28" height="2" rx="1" fill="black" />
      <rect x="14" y="6" width="6" height="10" rx="3" fill="black" />
      <rect x="24" y="6" width="6" height="10" rx="3" fill="black" />
    </svg>
  )
}

export function FigureRun({ size = 40, opacity = 0.2 }) {
  return (
    <svg width={size * 0.7} height={size} viewBox="0 0 30 44" fill="none" style={{ opacity }}>
      <circle cx="20" cy="5" r="4" fill="black" />
      <path
        d="M18 10L14 22L8 30M18 10L22 18L28 16M14 22L10 32L16 40M14 22L20 24L24 34"
        stroke="black"
        strokeWidth="3"
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </svg>
  )
}

export function FigureClimbing({ size = 40, opacity = 0.2 }) {
  return (
    <svg width={size * 0.7} height={size} viewBox="0 0 30 44" fill="none" style={{ opacity }}>
      <circle cx="15" cy="5" r="4" fill="black" />
      <path
        d="M15 10L10 20L6 28M15 10L20 16L26 14M10 20L12 32L8 40M10 20L18 22L22 34"
        stroke="black"
        strokeWidth="3"
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </svg>
  )
}

export function SmartWatch({ size = 40, opacity = 0.2 }) {
  return (
    <svg width={size * 0.75} height={size} viewBox="0 0 30 40" fill="none" style={{ opacity }}>
      <rect x="7" y="10" width="16" height="20" rx="4" fill="black" />
      <rect x="9" y="6" width="12" height="6" rx="2" fill="black" />
      <rect x="9" y="28" width="12" height="6" rx="2" fill="black" />
      <rect x="8" y="16" width="14" height="8" rx="2" fill="white" opacity="0.3" />
    </svg>
  )
}

export function StrengthFigure({ size = 18, color = 'rgba(60,60,67,0.3)' }) {
  return (
    <svg width={size} height={size} viewBox="0 0 18 18" fill="none">
      <circle cx="9" cy="3" r="2" fill={color} />
      <path
        d="M5 7H13M9 7V13M6 10H12M6 13L4 17M12 13L14 17"
        stroke={color}
        strokeWidth="1.5"
        strokeLinecap="round"
      />
    </svg>
  )
}

export function DumbbellSmall({ size = 11, color = 'white' }) {
  return (
    <svg width={size * 1.8} height={size} viewBox="0 0 20 11" fill="none">
      <rect x="0" y="3" width="4" height="5" rx="1.5" fill={color} />
      <rect x="16" y="3" width="4" height="5" rx="1.5" fill={color} />
      <rect x="4" y="4.5" width="12" height="2" fill={color} />
      <rect x="6" y="1" width="3" height="9" rx="1.5" fill={color} />
      <rect x="11" y="1" width="3" height="9" rx="1.5" fill={color} />
    </svg>
  )
}
