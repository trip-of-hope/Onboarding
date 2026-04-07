import { useState } from 'react'
import { AnimatePresence, motion } from 'framer-motion'
import { FigureRun, FigureClimbing, SmartWatch } from '../icons'
import PrimaryButton from '../components/PrimaryButton'

const STEPS = [
  { Icon: FigureRun, description: 'What Motra Does: Screen 1', buttonTitle: 'Continue' },
  { Icon: FigureClimbing, description: 'What Motra Does: Screen 2', buttonTitle: 'Continue' },
  { Icon: SmartWatch, description: 'What Motra Does: Screen 3', buttonTitle: 'Continue' },
]

export default function ValuePropFlowScreen({ onComplete }) {
  const [currentStep, setCurrentStep] = useState(0)

  const step = STEPS[currentStep]

  const handleContinue = () => {
    if (currentStep < STEPS.length - 1) {
      setCurrentStep(s => s + 1)
    } else {
      onComplete()
    }
  }

  return (
    <div style={{
      flex: 1,
      display: 'flex',
      flexDirection: 'column',
      background: 'white',
    }}>
      <div style={{ height: 80 }} />

      {/* Title */}
      <h1 style={{
        fontSize: 24,
        fontWeight: 600,
        textAlign: 'center',
        color: 'black',
        flexShrink: 0,
      }}>
        Welcome to Motra!
      </h1>

      <div style={{ flex: 1 }} />

      {/* Content card */}
      <div style={{
        display: 'flex',
        justifyContent: 'center',
        flexShrink: 0,
      }}>
        <div style={{
          width: 336,
          height: 448,
          background: 'white',
          borderRadius: 24,
          boxShadow: '0 0 80px rgba(0,0,0,0.12)',
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
          overflow: 'hidden',
          position: 'relative',
        }}>
          <AnimatePresence mode="wait">
            <motion.div
              key={currentStep}
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              exit={{ opacity: 0 }}
              transition={{ duration: 0.3, ease: 'easeInOut' }}
              style={{
                display: 'flex',
                flexDirection: 'column',
                alignItems: 'center',
                gap: 30,
                padding: '0 44px',
              }}
            >
              <step.Icon size={40} opacity={0.2} />
              <p style={{
                fontSize: 17,
                fontWeight: 500,
                textAlign: 'center',
                color: 'black',
                maxWidth: 252,
                lineHeight: 1.5,
              }}>
                {step.description}
              </p>
            </motion.div>
          </AnimatePresence>
        </div>
      </div>

      <div style={{ flex: 1 }} />

      {/* Button */}
      <div style={{ paddingLeft: 33, paddingRight: 33, paddingBottom: 24, flexShrink: 0 }}>
        <PrimaryButton title={step.buttonTitle} onClick={handleContinue} />
      </div>
    </div>
  )
}
