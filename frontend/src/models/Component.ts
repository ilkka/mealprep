export class Component {
  id: number
  name: string
  unit: string
  visible: boolean
}

export class ComponentValue {
  component: Component
  value: number
}
