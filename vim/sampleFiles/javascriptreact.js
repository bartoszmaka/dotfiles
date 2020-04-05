import React, { Component, useState } from 'react'

export class SampleClass extends Component {
  componentDidMount() {
    console.log('mounted')
  }

  renderFoos = (foos) =>
    foos.map(foo => <div>{foo}</div>)

  render() {
    return (
      <div>
        <SampleComponent />
      </div>
    )
  }
}

const SampleComponent = ({
  name,
  id,
  onClick,
  onClose,
}) => {
  const [isOpen, setIsOpen] = useState(false)

  const handleSomething = () => {}

  return (
    <>
      <h2>{name}</h2>
      <button type="button" onClick={onClick}></button>
    </>
  )
}

export default SampleClass


