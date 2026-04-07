import { useState } from 'react'
import { AnimatePresence, motion } from 'framer-motion'
import { ChevronLeft, HeartFill, BellFill, DumbbellFill, FigureRun, SmartWatch } from '../icons'
import OptionRow from '../components/OptionRow'
import ProgressBar from '../components/ProgressBar'
import PrimaryButton from '../components/PrimaryButton'
import SecondaryButton from '../components/SecondaryButton'
import WeightRuler from '../components/WeightRuler'

// ─── Step definitions ───────────────────────────────────────────────────────

const STEPS = {
  appleWatch: 'appleWatch',
  appleHealthWithWatch: 'appleHealthWithWatch',
  watchAutoDetection: 'watchAutoDetection',
  noWatchInfo: 'noWatchInfo',
  appleHealthWithoutWatch: 'appleHealthWithoutWatch',
  goalSelection: 'goalSelection',
  barrierSelection: 'barrierSelection',
  desiredWeight: 'desiredWeight',
  personalizedMessage: 'personalizedMessage',
  trainingExperience: 'trainingExperience',
  trainingSupportActivities: 'trainingSupportActivities',
  weeklySessions: 'weeklySessions',
  experienceMessaging: 'experienceMessaging',
  trainingLocation: 'trainingLocation',
  injurySelection: 'injurySelection',
  firstWorkoutFocus: 'firstWorkoutFocus',
  workoutReminders: 'workoutReminders',
  acquisitionSource: 'acquisitionSource',
}

function getProgress(step) {
  const map = {
    appleWatch: 1,
    appleHealthWithWatch: 2, noWatchInfo: 2,
    watchAutoDetection: 3, appleHealthWithoutWatch: 3,
    goalSelection: 4,
    barrierSelection: 5,
    desiredWeight: 6,
    personalizedMessage: 7,
    trainingExperience: 8,
    trainingSupportActivities: 9,
    weeklySessions: 10,
    experienceMessaging: 11,
    trainingLocation: 12,
    injurySelection: 13,
    firstWorkoutFocus: 14,
    workoutReminders: 15,
    acquisitionSource: 16,
  }
  return map[step] ?? 1
}

function getNextStep(step, state) {
  switch (step) {
    case STEPS.appleWatch:
      return state.hasAppleWatch === true ? STEPS.appleHealthWithWatch : STEPS.noWatchInfo
    case STEPS.appleHealthWithWatch:
      return STEPS.watchAutoDetection
    case STEPS.watchAutoDetection:
      return STEPS.goalSelection
    case STEPS.noWatchInfo:
      return STEPS.appleHealthWithoutWatch
    case STEPS.appleHealthWithoutWatch:
      return STEPS.goalSelection
    case STEPS.goalSelection:
      return STEPS.barrierSelection
    case STEPS.barrierSelection:
      return state.goal === 'Lose weight' ? STEPS.desiredWeight : STEPS.personalizedMessage
    case STEPS.desiredWeight:
      return STEPS.personalizedMessage
    case STEPS.personalizedMessage:
      return STEPS.trainingExperience
    case STEPS.trainingExperience:
      return STEPS.trainingSupportActivities
    case STEPS.trainingSupportActivities:
      return STEPS.weeklySessions
    case STEPS.weeklySessions:
      return STEPS.experienceMessaging
    case STEPS.experienceMessaging:
      return STEPS.trainingLocation
    case STEPS.trainingLocation:
      return STEPS.injurySelection
    case STEPS.injurySelection:
      return STEPS.firstWorkoutFocus
    case STEPS.firstWorkoutFocus:
      return STEPS.workoutReminders
    case STEPS.workoutReminders:
      return STEPS.acquisitionSource
    case STEPS.acquisitionSource:
      return null
    default:
      return null
  }
}

function isStepValid(step, state) {
  switch (step) {
    case STEPS.appleWatch: return state.hasAppleWatch !== null
    case STEPS.goalSelection: return state.goal !== null
    case STEPS.barrierSelection: return state.barrier !== null
    case STEPS.trainingExperience: return state.trainingExperience !== null
    case STEPS.trainingSupportActivities: return state.supportingActivities.size > 0
    case STEPS.weeklySessions: return state.weeklySessions !== null
    case STEPS.trainingLocation: return state.trainingLocation !== null
    case STEPS.injurySelection: return state.injuries.size > 0
    case STEPS.firstWorkoutFocus: return state.workoutFocus !== null
    case STEPS.acquisitionSource: return state.acquisitionSource !== null
    default: return true
  }
}

function getButtonTitle(step) {
  if (step === STEPS.appleHealthWithWatch || step === STEPS.appleHealthWithoutWatch)
    return 'Connect to Apple Health'
  if (step === STEPS.workoutReminders)
    return 'Enable Reminders'
  return 'Continue'
}

function getExperienceMessagingText(trainingExperience, supportingActivities) {
  const crossTraining = supportingActivities.size > 0 &&
    !(supportingActivities.size === 1 && supportingActivities.has('No, strength is my main focus'))
  switch (trainingExperience) {
    case 'Just starting out':
      return crossTraining
        ? "Your other activities will complement your strength training. We'll keep sessions efficient and manageable."
        : "Everyone starts somewhere. We'll build your foundation step by step, with sessions designed for progress."
    case '1–2 years':
      return crossTraining
        ? "A great base — we'll design sessions that fit around your other training without overloading you."
        : "You've got a solid foundation. We'll build on what you know and keep you progressing."
    case '3–5 years':
      return crossTraining
        ? "With your experience, we'll balance your strength work to complement everything else you're doing."
        : "Solid experience. We'll push performance further and keep things challenging."
    case '5+ years':
      return crossTraining
        ? "Impressive. We'll program sessions that fit your broader training demands and keep you performing at your best."
        : "With your background, we'll focus on what moves the needle — refined programming for experienced athletes."
    default:
      return "We'll build a plan tailored to your experience and goals."
  }
}

// ─── Step content components ─────────────────────────────────────────────────

function AppleWatchContent({ state, update }) {
  return (
    <div style={{ flex: 1, display: 'flex', flexDirection: 'column' }}>
      <div style={{ height: 40 }} />
      <h2 style={{
        fontSize: 24, fontWeight: 600, textAlign: 'center',
        paddingLeft: 33, paddingRight: 33, color: 'black', lineHeight: 1.3,
      }}>
        Do you have an Apple Watch?
      </h2>
      <div style={{ height: 16 }} />
      <p style={{
        fontSize: 17, textAlign: 'center', color: 'rgba(0,0,0,0.6)',
        paddingLeft: 40, paddingRight: 40, lineHeight: 1.5,
      }}>
        Motra tracks exercises and repetitions automatically – no phone needed during your workout.
      </p>
      <div style={{ flex: 1 }} />
      <div style={{ paddingLeft: 20, paddingRight: 20, display: 'flex', flexDirection: 'column', gap: 16 }}>
        <BinaryButton
          title="Yes"
          selected={state.hasAppleWatch === true}
          onClick={() => update({ hasAppleWatch: true })}
        />
        <BinaryButton
          title="No"
          selected={state.hasAppleWatch === false}
          onClick={() => update({ hasAppleWatch: false })}
        />
      </div>
      <div style={{ flex: 1 }} />
    </div>
  )
}

function BinaryButton({ title, selected, onClick }) {
  return (
    <button
      onClick={onClick}
      style={{
        width: '100%', height: 60,
        background: selected ? 'black' : '#F2F2F7',
        borderRadius: 20,
        fontSize: 17, fontWeight: 500,
        color: selected ? 'white' : 'black',
        transition: 'background 0.15s, color 0.15s',
      }}
    >
      {title}
    </button>
  )
}

function AppleHealthContent({ withWatch }) {
  const description = withWatch
    ? 'Motra needs your Health data to analyze your performance, recommend you activities and log your workouts with Apple Watch.'
    : 'Motra needs your Health data to analyze your performance and recommend you activities.'
  return (
    <div style={{ flex: 1, display: 'flex', flexDirection: 'column', justifyContent: 'center' }}>
      <div style={{
        paddingLeft: 51, paddingRight: 51,
        display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 32,
      }}>
        <HeartFill size={40} opacity={0.2} />
        <h2 style={{
          fontSize: 24, fontWeight: 600, textAlign: 'center', color: 'black', lineHeight: 1.3,
        }}>
          Allow access to Apple Health
        </h2>
        <p style={{
          fontSize: 17, textAlign: 'center', color: 'black', lineHeight: 1.5,
        }}>
          {description}
        </p>
      </div>
    </div>
  )
}

function InfoCardContent({ Icon, text }) {
  return (
    <div style={{ flex: 1, display: 'flex', flexDirection: 'column', justifyContent: 'center', alignItems: 'center' }}>
      <div style={{
        width: 336,
        background: 'white',
        borderRadius: 24,
        boxShadow: '0 0 80px rgba(0,0,0,0.12)',
        padding: '60px 44px',
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        gap: 30,
        minHeight: 200,
        justifyContent: 'center',
      }}>
        <Icon size={40} opacity={0.2} />
        <p style={{
          fontSize: 17, fontWeight: 500, textAlign: 'center',
          color: 'black', maxWidth: 252, lineHeight: 1.5,
          whiteSpace: 'pre-wrap',
        }}>
          {text}
        </p>
      </div>
    </div>
  )
}

function SingleSelectContent({ title, subtitle, options, selection, onSelect }) {
  const isTwoOptions = options.length === 2
  return (
    <div style={{ flex: 1, display: 'flex', flexDirection: 'column', overflow: 'hidden' }}>
      <div style={{ height: 40 }} />
      <h2 style={{
        fontSize: 24, fontWeight: 600, textAlign: 'center',
        paddingLeft: 33, paddingRight: 33, color: 'black',
        lineHeight: 1.3, flexShrink: 0,
      }}>
        {title}
      </h2>
      {subtitle && (
        <>
          <div style={{ height: 16 }} />
          <p style={{
            fontSize: 17, textAlign: 'center', color: 'rgba(0,0,0,0.6)',
            paddingLeft: 40, paddingRight: 40, lineHeight: 1.5, flexShrink: 0,
          }}>
            {subtitle}
          </p>
        </>
      )}
      {isTwoOptions ? (
        <>
          <div style={{ flex: 1 }} />
          <div style={{ paddingLeft: 20, paddingRight: 20, display: 'flex', flexDirection: 'column', gap: 16 }}>
            {options.map(opt => (
              <OptionRow key={opt} title={opt} isSelected={selection === opt} onClick={() => onSelect(opt)} />
            ))}
          </div>
          <div style={{ flex: 1 }} />
        </>
      ) : (
        <>
          <div style={{ height: 40 }} />
          <div style={{ flex: 1, overflowY: 'auto', WebkitOverflowScrolling: 'touch' }}>
            <div style={{
              paddingLeft: 20, paddingRight: 20,
              display: 'flex', flexDirection: 'column', gap: 16, paddingBottom: 8,
            }}>
              {options.map(opt => (
                <OptionRow key={opt} title={opt} isSelected={selection === opt} onClick={() => onSelect(opt)} />
              ))}
            </div>
          </div>
        </>
      )}
    </div>
  )
}

function MultiSelectContent({ title, subtitle, options, selection, exclusiveOption, onToggle }) {
  const isTwoOptions = options.length === 2
  return (
    <div style={{ flex: 1, display: 'flex', flexDirection: 'column', overflow: 'hidden' }}>
      <div style={{ height: 40 }} />
      <h2 style={{
        fontSize: 24, fontWeight: 600, textAlign: 'center',
        paddingLeft: 33, paddingRight: 33, color: 'black',
        lineHeight: 1.3, flexShrink: 0,
      }}>
        {title}
      </h2>
      {subtitle && (
        <>
          <div style={{ height: 16 }} />
          <p style={{
            fontSize: 17, textAlign: 'center', color: 'rgba(0,0,0,0.6)',
            paddingLeft: 40, paddingRight: 40, lineHeight: 1.5, flexShrink: 0,
          }}>
            {subtitle}
          </p>
        </>
      )}
      {isTwoOptions ? (
        <>
          <div style={{ flex: 1 }} />
          <div style={{ paddingLeft: 20, paddingRight: 20, display: 'flex', flexDirection: 'column', gap: 16 }}>
            {options.map(opt => (
              <OptionRow key={opt} title={opt} isSelected={selection.has(opt)} onClick={() => onToggle(opt)} />
            ))}
          </div>
          <div style={{ flex: 1 }} />
        </>
      ) : (
        <>
          <div style={{ height: 40 }} />
          <div style={{ flex: 1, overflowY: 'auto', WebkitOverflowScrolling: 'touch' }}>
            <div style={{
              paddingLeft: 20, paddingRight: 20,
              display: 'flex', flexDirection: 'column', gap: 16, paddingBottom: 8,
            }}>
              {options.map(opt => (
                <OptionRow key={opt} title={opt} isSelected={selection.has(opt)} onClick={() => onToggle(opt)} />
              ))}
            </div>
          </div>
        </>
      )}
    </div>
  )
}

function DesiredWeightContent({ weight, onChange }) {
  const formatted = weight.toFixed(1)
  return (
    <div style={{ flex: 1, display: 'flex', flexDirection: 'column' }}>
      <div style={{ height: 40 }} />
      <h2 style={{
        fontSize: 24, fontWeight: 600, textAlign: 'center',
        paddingLeft: 33, paddingRight: 33, color: 'black', lineHeight: 1.3,
      }}>
        What's your desired weight?
      </h2>
      <div style={{ flex: 1 }} />
      <div style={{ display: 'flex', justifyContent: 'center', alignItems: 'baseline', gap: 6 }}>
        <span style={{ fontSize: 52, fontWeight: 700, color: 'black', fontVariantNumeric: 'tabular-nums' }}>
          {formatted}
        </span>
        <span style={{ fontSize: 17, color: 'rgba(60,60,67,0.6)' }}>kg</span>
      </div>
      <div style={{ height: 32 }} />
      <div style={{ paddingLeft: 24, paddingRight: 24 }}>
        <WeightRuler weight={weight} onChange={onChange} />
      </div>
      <div style={{ flex: 1 }} />
    </div>
  )
}

function PermissionContent({ Icon, title, description }) {
  return (
    <div style={{ flex: 1, display: 'flex', flexDirection: 'column', justifyContent: 'center' }}>
      <div style={{
        paddingLeft: 51, paddingRight: 51,
        display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 32,
      }}>
        <Icon size={40} opacity={0.2} />
        <h2 style={{
          fontSize: 24, fontWeight: 600, textAlign: 'center', color: 'black', lineHeight: 1.3,
        }}>
          {title}
        </h2>
        <p style={{
          fontSize: 17, textAlign: 'center', color: 'black', lineHeight: 1.5,
        }}>
          {description}
        </p>
      </div>
    </div>
  )
}

// ─── Main GoalsFlowScreen ────────────────────────────────────────────────────

export default function GoalsFlowScreen({ state, update, onComplete, onBack }) {
  const [currentStep, setCurrentStep] = useState(STEPS.appleWatch)
  const [history, setHistory] = useState([])
  const [forward, setForward] = useState(true)

  const valid = isStepValid(currentStep, state)

  const advance = () => {
    const next = getNextStep(currentStep, state)
    if (!next) { onComplete(); return }
    setHistory(h => [...h, currentStep])
    setForward(true)
    setCurrentStep(next)
  }

  const goBack = () => {
    if (history.length === 0) { onBack(); return }
    const prev = history[history.length - 1]
    setHistory(h => h.slice(0, -1))
    setForward(false)
    setCurrentStep(prev)
  }

  const toggleSupportingActivity = (option) => {
    const exclusive = 'No, strength is my main focus'
    const next = new Set(state.supportingActivities)
    if (option === exclusive) {
      update({ supportingActivities: new Set([exclusive]) })
    } else {
      next.delete(exclusive)
      if (next.has(option)) { next.delete(option) } else { next.add(option) }
      update({ supportingActivities: next })
    }
  }

  const toggleInjury = (option) => {
    const exclusive = 'No issues'
    const next = new Set(state.injuries)
    if (option === exclusive) {
      update({ injuries: new Set([exclusive]) })
    } else {
      next.delete(exclusive)
      if (next.has(option)) { next.delete(option) } else { next.add(option) }
      update({ injuries: next })
    }
  }

  const renderContent = () => {
    switch (currentStep) {
      case STEPS.appleWatch:
        return <AppleWatchContent state={state} update={update} />
      case STEPS.appleHealthWithWatch:
        return <AppleHealthContent withWatch={true} />
      case STEPS.watchAutoDetection:
        return <InfoCardContent Icon={SmartWatch} text="Auto-detection Messaging" />
      case STEPS.noWatchInfo:
        return (
          <InfoCardContent
            Icon={SmartWatch}
            text={"You get the best experience from Motra with Apple Watch.\n\nBut you can still use AI coaching and log your workouts manually."}
          />
        )
      case STEPS.appleHealthWithoutWatch:
        return <AppleHealthContent withWatch={false} />
      case STEPS.goalSelection:
        return (
          <SingleSelectContent
            title="What's your goal?"
            subtitle="Choose a goal that you think suits you best."
            options={['Build strength', 'Lose weight', 'Build muscle', 'Improve overall health', 'Other']}
            selection={state.goal}
            onSelect={(v) => update({ goal: v })}
          />
        )
      case STEPS.barrierSelection:
        return (
          <SingleSelectContent
            title="What's held you back before?"
            subtitle="What is preventing you from achieving your goal?"
            options={['Lack of motivation', 'Too busy / no time', 'Not sure where to start', 'Previous injuries', 'Other']}
            selection={state.barrier}
            onSelect={(v) => update({ barrier: v })}
          />
        )
      case STEPS.desiredWeight:
        return (
          <DesiredWeightContent
            weight={state.desiredWeight}
            onChange={(v) => update({ desiredWeight: v })}
          />
        )
      case STEPS.personalizedMessage:
        return <InfoCardContent Icon={FigureRun} text="Messaging based on your goal and reason." />
      case STEPS.trainingExperience:
        return (
          <SingleSelectContent
            title="How much weight training experience do you have?"
            subtitle={null}
            options={['Just starting out', '1–2 years', '3–5 years', '5+ years']}
            selection={state.trainingExperience}
            onSelect={(v) => update({ trainingExperience: v })}
          />
        )
      case STEPS.trainingSupportActivities:
        return (
          <MultiSelectContent
            title="Is your training supporting anything else?"
            subtitle={null}
            options={[
              'No, strength is my main focus',
              'Running or endurance sports',
              'Cycling',
              'Team sports (football, basketball, etc.)',
              'Another sport or activity',
            ]}
            selection={state.supportingActivities}
            exclusiveOption="No, strength is my main focus"
            onToggle={toggleSupportingActivity}
          />
        )
      case STEPS.weeklySessions:
        return (
          <SingleSelectContent
            title="How many strength sessions a week are you aiming for?"
            subtitle={null}
            options={['1–2 sessions', '3 sessions', '4 sessions', '5+ sessions']}
            selection={state.weeklySessions}
            onSelect={(v) => update({ weeklySessions: v })}
          />
        )
      case STEPS.experienceMessaging:
        return (
          <InfoCardContent
            Icon={DumbbellFill}
            text={getExperienceMessagingText(state.trainingExperience, state.supportingActivities)}
          />
        )
      case STEPS.trainingLocation:
        return (
          <SingleSelectContent
            title="Where do you prefer to train?"
            subtitle={null}
            options={['Full gym', 'Home gym', 'Minimal equipment', 'Combination']}
            selection={state.trainingLocation}
            onSelect={(v) => update({ trainingLocation: v })}
          />
        )
      case STEPS.injurySelection:
        return (
          <MultiSelectContent
            title="Do you have any injuries?"
            subtitle={null}
            options={['No issues', 'Back', 'Knees', 'Shoulders', 'Other']}
            selection={state.injuries}
            exclusiveOption="No issues"
            onToggle={toggleInjury}
          />
        )
      case STEPS.firstWorkoutFocus:
        return (
          <SingleSelectContent
            title="What would you like your first workout to focus on?"
            subtitle={null}
            options={['Upper Body', 'Lower Body', 'Full Body', 'Core', 'Not sure']}
            selection={state.workoutFocus}
            onSelect={(v) => update({ workoutFocus: v })}
          />
        )
      case STEPS.workoutReminders:
        return (
          <PermissionContent
            Icon={BellFill}
            title="Stay on top of your plan with workout reminders."
            description="Motra will send you timely reminders so you never miss a session. You can adjust or turn these off at any time in Settings."
          />
        )
      case STEPS.acquisitionSource:
        return (
          <SingleSelectContent
            title="How did you hear about us?"
            subtitle={null}
            options={['Instagram', 'TikTok', 'App Store', 'Facebook', 'YouTube', 'Google Search', 'Word of mouth', 'Other']}
            selection={state.acquisitionSource}
            onSelect={(v) => update({ acquisitionSource: v })}
          />
        )
      default:
        return null
    }
  }

  const slideVariants = {
    enterFromRight: { x: '100%', opacity: 0 },
    enterFromLeft: { x: '-100%', opacity: 0 },
    center: { x: 0, opacity: 1 },
    exitToLeft: { x: '-100%', opacity: 0 },
    exitToRight: { x: '100%', opacity: 0 },
  }

  return (
    <div style={{
      flex: 1,
      display: 'flex',
      flexDirection: 'column',
      background: 'white',
      overflow: 'hidden',
    }}>
      {/* Toolbar */}
      <div className="toolbar">
        <button className="toolbar-back" onClick={goBack}>
          <ChevronLeft />
        </button>
        <div className="toolbar-center">
          <ProgressBar current={getProgress(currentStep)} total={16} />
        </div>
      </div>

      {/* Animated step content */}
      <div style={{ flex: 1, position: 'relative', overflow: 'hidden', display: 'flex', flexDirection: 'column' }}>
        <AnimatePresence mode="sync" custom={forward}>
          <motion.div
            key={currentStep}
            custom={forward}
            variants={slideVariants}
            initial={forward ? 'enterFromRight' : 'enterFromLeft'}
            animate="center"
            exit={forward ? 'exitToLeft' : 'exitToRight'}
            transition={{ duration: 0.28, ease: 'easeInOut' }}
            style={{
              position: 'absolute',
              inset: 0,
              display: 'flex',
              flexDirection: 'column',
              overflow: 'hidden',
            }}
          >
            {renderContent()}
          </motion.div>
        </AnimatePresence>
      </div>

      {/* Fixed button(s) */}
      {currentStep === STEPS.workoutReminders ? (
        <div style={{
          paddingLeft: 33, paddingRight: 33, paddingBottom: 24,
          display: 'flex', flexDirection: 'column', gap: 12, flexShrink: 0,
        }}>
          <PrimaryButton
            title="Enable Reminders"
            onClick={() => { update({ reminderPermission: true }); advance() }}
          />
          <SecondaryButton title="Skip" onClick={advance} />
        </div>
      ) : (
        <div style={{ paddingLeft: 33, paddingRight: 33, paddingBottom: 24, flexShrink: 0 }}>
          <PrimaryButton title={getButtonTitle(currentStep)} onClick={advance} disabled={!valid} />
        </div>
      )}
    </div>
  )
}
