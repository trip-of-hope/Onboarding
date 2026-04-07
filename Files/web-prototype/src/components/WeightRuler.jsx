import { useRef, useEffect } from 'react'

const MIN_WEIGHT = 30
const MAX_WEIGHT = 200
const POINTS_PER_KG = 56

export default function WeightRuler({ weight, onChange }) {
  const canvasRef = useRef(null)
  const dragRef = useRef({ active: false, startX: 0, startWeight: weight })

  useEffect(() => {
    const canvas = canvasRef.current
    if (!canvas) return

    const dpr = window.devicePixelRatio || 1
    const rect = canvas.getBoundingClientRect()
    if (rect.width === 0) return

    // Resize only when needed
    if (canvas.width !== Math.round(rect.width * dpr) || canvas.height !== Math.round(rect.height * dpr)) {
      canvas.width = Math.round(rect.width * dpr)
      canvas.height = Math.round(rect.height * dpr)
    }

    const cssW = rect.width
    const cssH = rect.height
    const ctx = canvas.getContext('2d')

    // Always reset transform before drawing
    ctx.setTransform(dpr, 0, 0, dpr, 0, 0)
    ctx.clearRect(0, 0, cssW, cssH)

    const centerX = cssW / 2
    const visibleRange = cssW / POINTS_PER_KG + 2
    let v = Math.floor((weight - visibleRange / 2) * 10) / 10
    const endV = weight + visibleRange / 2

    while (v <= endV) {
      const x = centerX + (v - weight) * POINTS_PER_KG
      if (x >= -2 && x <= cssW + 2) {
        const rem = Math.round(v * 10) % 10
        const isWhole = Math.abs(rem) < 0.5
        const isHalf = Math.abs(Math.abs(rem) - 5) < 0.5
        const tickH = isWhole ? 36 : (isHalf ? 22 : 12)
        const alpha = isWhole ? 0.35 : 0.18
        const lw = isWhole ? 2 : 1

        ctx.beginPath()
        ctx.moveTo(x, cssH - tickH)
        ctx.lineTo(x, cssH)
        ctx.strokeStyle = `rgba(0,0,0,${alpha})`
        ctx.lineWidth = lw
        ctx.stroke()

        if (isWhole) {
          ctx.font = '12px -apple-system, BlinkMacSystemFont, sans-serif'
          ctx.fillStyle = 'rgba(0,0,0,0.3)'
          ctx.textAlign = 'center'
          ctx.textBaseline = 'bottom'
          ctx.fillText(String(Math.round(v)), x, cssH - tickH - 4)
        }
      }
      v = Math.round(v * 10 + 1) / 10
    }

    // Center indicator
    ctx.beginPath()
    ctx.moveTo(centerX, 0)
    ctx.lineTo(centerX, cssH)
    ctx.strokeStyle = 'black'
    ctx.lineWidth = 2
    ctx.stroke()
  }, [weight])

  const handlePointerDown = (e) => {
    e.currentTarget.setPointerCapture(e.pointerId)
    dragRef.current = { active: true, startX: e.clientX, startWeight: weight }
  }

  const handlePointerMove = (e) => {
    if (!dragRef.current.active) return
    const delta = -(e.clientX - dragRef.current.startX) / POINTS_PER_KG
    let next = Math.round((dragRef.current.startWeight + delta) * 10) / 10
    next = Math.min(MAX_WEIGHT, Math.max(MIN_WEIGHT, next))
    onChange(next)
  }

  const handlePointerUp = () => {
    dragRef.current.active = false
  }

  return (
    <canvas
      ref={canvasRef}
      style={{
        width: '100%',
        height: 80,
        display: 'block',
        cursor: 'ew-resize',
        touchAction: 'none',
      }}
      onPointerDown={handlePointerDown}
      onPointerMove={handlePointerMove}
      onPointerUp={handlePointerUp}
      onPointerCancel={handlePointerUp}
    />
  )
}
