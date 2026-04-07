export default function RoundedInputField({
  placeholder,
  value,
  onChange,
  type = 'text',
  autoFocus = false,
}) {
  return (
    <input
      type={type}
      placeholder={placeholder}
      value={value}
      onChange={(e) => onChange(e.target.value)}
      autoFocus={autoFocus}
      autoComplete="off"
      autoCorrect="off"
      autoCapitalize="none"
      spellCheck="false"
      style={{
        width: '100%',
        height: 56,
        paddingLeft: 20,
        paddingRight: 20,
        fontSize: 17,
        fontWeight: 500,
        color: 'black',
        background: '#F2F2F7',
        borderRadius: 20,
        display: 'block',
        flexShrink: 0,
      }}
    />
  )
}
