import { useState, useEffect } from 'react'
import { motion } from 'framer-motion'
import { DumbbellSmall, StrengthFigure } from '../icons'
import PrimaryButton from '../components/PrimaryButton'

const WEEK_PLAN = [
  {
    label: 'Day 1:',
    exercises: [
      { name: 'Barbell Bench Press', detail: '3 x 10 Reps  •  45–55 Lbs' },
      { name: 'Dumbbell Incline Bicep Curl', detail: '3 x 10 Reps  •  15–20 Lbs' },
      { name: 'Bicycle Crunch', detail: '3 x 10 Reps' },
      { name: 'Dumbbell Tricep Kickback', detail: '3 x 10 Reps  •  10–20 Lbs' },
      { name: 'ATG Split Squat', detail: '3 x 10 Reps' },
      { name: 'Dumbbell Fly', detail: '3 x 10 Reps  •  10–20 Lbs' },
    ],
  },
  {
    label: 'Day 2:',
    exercises: [
      { name: 'Barbell Bench Press', detail: '3 x 10 Reps  •  45–55 Lbs' },
      { name: 'Dumbbell Incline Bicep Curl', detail: '3 x 10 Reps  •  15–20 Lbs' },
      { name: 'Bicycle Crunch', detail: '3 x 10 Reps' },
      { name: 'Dumbbell Tricep Kickback', detail: '3 x 10 Reps  •  10–20 Lbs' },
      { name: 'ATG Split Squat', detail: '3 x 10 Reps' },
      { name: 'Dumbbell Fly', detail: '3 x 10 Reps  •  10–20 Lbs' },
    ],
  },
  {
    label: 'Day 3:',
    exercises: [
      { name: 'Barbell Bench Press', detail: '3 x 10 Reps  •  45–55 Lbs' },
      { name: 'Dumbbell Incline Bicep Curl', detail: '3 x 10 Reps  •  15–20 Lbs' },
      { name: 'Bicycle Crunch', detail: '3 x 10 Reps' },
      { name: 'Dumbbell Tricep Kickback', detail: '3 x 10 Reps  •  10–20 Lbs' },
      { name: 'ATG Split Squat', detail: '3 x 10 Reps' },
      { name: 'Dumbbell Fly', detail: '3 x 10 Reps  •  10–20 Lbs' },
    ],
  },
]

const WEEK_DAYS = [
  { label: 'TODAY', day: null, isWorkout: true },
  { label: 'MON', day: '8', isWorkout: false },
  { label: 'TUE', day: '9', isWorkout: false },
  { label: 'WED', day: '10', isWorkout: true },
  { label: 'THU', day: '11', isWorkout: false },
  { label: 'FRI', day: '12', isWorkout: true },
  { label: 'SAT', day: '13', isWorkout: false },
]

function WeekDayCell({ label, day, isWorkout }) {
  return (
    <div style={{
      flex: 1, display: 'flex', flexDirection: 'column',
      alignItems: 'center', gap: 8,
    }}>
      <div style={{
        width: 36, height: 36, borderRadius: '50%',
        background: isWorkout ? 'black' : 'rgba(116,116,128,0.08)',
        display: 'flex', alignItems: 'center', justifyContent: 'center',
      }}>
        {isWorkout
          ? <DumbbellSmall size={11} color="white" />
          : day && (
            <span style={{ fontSize: 13, fontWeight: 600, color: 'rgba(60,60,67,0.3)' }}>
              {day}
            </span>
          )
        }
      </div>
      <span style={{
        fontSize: 11,
        fontWeight: 600,
        letterSpacing: 0.5,
        color: isWorkout ? 'black' : 'rgba(60,60,67,0.3)',
      }}>
        {label}
      </span>
    </div>
  )
}

function ExerciseCard({ exercise }) {
  return (
    <div style={{
      display: 'flex',
      alignItems: 'center',
      gap: 12,
      padding: 12,
      background: 'rgba(116,116,128,0.04)',
      borderRadius: 16,
    }}>
      <div style={{
        width: 50, height: 50, borderRadius: 12,
        background: 'rgba(116,116,128,0.12)',
        display: 'flex', alignItems: 'center', justifyContent: 'center',
        flexShrink: 0,
      }}>
        <StrengthFigure size={18} color="rgba(60,60,67,0.3)" />
      </div>
      <div>
        <p style={{
          fontSize: 14, fontWeight: 600, color: 'black',
          letterSpacing: '-0.4px', lineHeight: 1.3,
        }}>
          {exercise.name}
        </p>
        <p style={{
          fontSize: 12, fontWeight: 500, color: 'rgba(60,60,67,0.6)',
          letterSpacing: '-0.25px', marginTop: 6,
        }}>
          {exercise.detail}
        </p>
      </div>
    </div>
  )
}

export default function PlanReadyScreen({ onComplete }) {
  const [appeared, setAppeared] = useState(false)

  useEffect(() => {
    const t = requestAnimationFrame(() => setAppeared(true))
    return () => cancelAnimationFrame(t)
  }, [])

  const fadeUp = (delay) => ({
    initial: { opacity: 0, y: 16 },
    animate: appeared ? { opacity: 1, y: 0 } : { opacity: 0, y: 16 },
    transition: { duration: 0.4, ease: 'easeOut', delay },
  })

  return (
    <div style={{ flex: 1, display: 'flex', flexDirection: 'column', background: 'white', position: 'relative' }}>
      {/* Scrollable content */}
      <div style={{ flex: 1, overflowY: 'auto', WebkitOverflowScrolling: 'touch' }}>
        <div style={{ paddingBottom: 96 }}>
          {/* Title + subtitle */}
          <motion.div {...fadeUp(0)} style={{
            paddingTop: 72,
            paddingLeft: 33,
            paddingRight: 33,
            display: 'flex',
            flexDirection: 'column',
            alignItems: 'center',
            gap: 12,
          }}>
            <h1 style={{
              fontSize: 24, fontWeight: 600, textAlign: 'center',
              color: 'black', letterSpacing: '-0.5px', lineHeight: 1.3,
            }}>
              Your first week of workouts is ready!
            </h1>
            <p style={{
              fontSize: 17, textAlign: 'center', color: 'rgba(0,0,0,0.6)',
              lineHeight: 1.5, paddingLeft: 8, paddingRight: 8,
            }}>
              Motra Coach can adjust your workout based on your feedback.
            </p>
          </motion.div>

          {/* Week strip */}
          <motion.div {...fadeUp(0.15)} style={{ paddingLeft: 24, paddingRight: 24, paddingTop: 24 }}>
            <div style={{
              background: 'rgba(116,116,128,0.06)',
              borderRadius: 16,
              padding: '16px 12px',
              display: 'flex',
            }}>
              {WEEK_DAYS.map(d => (
                <WeekDayCell key={d.label} {...d} />
              ))}
            </div>
          </motion.div>

          {/* Day sections */}
          {WEEK_PLAN.map((day, index) => (
            <motion.div
              key={day.label}
              {...fadeUp(0.3 + index * 0.15)}
              style={{ paddingLeft: 20, paddingRight: 20, paddingTop: 28 }}
            >
              <p style={{
                fontSize: 20, fontWeight: 600, color: 'black',
                letterSpacing: '-0.45px', marginBottom: 10,
              }}>
                {day.label}
              </p>
              <div style={{ display: 'flex', flexDirection: 'column', gap: 8 }}>
                {day.exercises.map((ex) => (
                  <ExerciseCard key={ex.name} exercise={ex} />
                ))}
              </div>
            </motion.div>
          ))}
        </div>
      </div>

      {/* Fixed "Start Now" button with gradient fade */}
      <motion.div
        initial={{ opacity: 0 }}
        animate={appeared ? { opacity: 1 } : { opacity: 0 }}
        transition={{ duration: 0.4, ease: 'easeOut', delay: 0.75 }}
        style={{
          position: 'absolute',
          bottom: 0,
          left: 0,
          right: 0,
          paddingLeft: 33,
          paddingRight: 33,
          paddingBottom: 24,
          paddingTop: 40,
          background: 'linear-gradient(to bottom, rgba(255,255,255,0) 0%, white 40%)',
        }}
      >
        <PrimaryButton title="Start Now" onClick={onComplete} />
      </motion.div>
    </div>
  )
}
