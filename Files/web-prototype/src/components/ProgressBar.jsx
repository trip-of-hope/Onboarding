export default function ProgressBar({ current, total }) {
  const trackWidth = 182
  const height = 6
  const fillWidth = (trackWidth * current) / total

  return (
    <div style={{
      width: trackWidth,
      height: height,
      background: 'rgba(120, 120, 128, 0.2)',
      borderRadius: 9999,
      position: 'relative',
      overflow: 'hidden',
    }}>
      <div style={{
        position: 'absolute',
        left: 0,
        top: 0,
        height: '100%',
        width: fillWidth,
        background: 'black',
        borderRadius: 9999,
        transition: 'width 0.28s ease-in-out',
      }} />
    </div>
  )
}
