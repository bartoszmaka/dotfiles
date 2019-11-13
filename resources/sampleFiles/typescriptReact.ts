import * as React from 'react';
import { FormData, FormMapping, WizardData } from "components/form_discovery/WizardData";
import { Form, FormControlProps } from 'react-bootstrap';

type FormMappingFields = keyof FormMapping;

export interface MappingProps {
  fieldName: FormMappingFields
  formFields: readonly string[]
  defaultFormMapping: FormMapping
  validationMessage?: string
  onFormMappingChange: (formMappingPartial: Partial<FormMapping>) => void
}

function fieldNameLabel(fieldName: FormMappingFields): string {
  switch(fieldName) {
    case "name": return "Full Name"
    case "firstName": return "First Name"
    case "lastName": return "Last Name"
    case "email": return "Lead email"
    case "phoneNumber": return "Lead phone number"
    case "enquiry": return "Lead enquiry"
  }
}

export const pleaseSelectFieldString = "Please select field";

export const MappingField: React.FC<MappingProps> = function MappingField(props) {
  const {fieldName, formFields} = props;

  function onformActionMappingChange(e: React.FormEvent<FormControlProps>) {
    props.onFormMappingChange({[fieldName]: e.currentTarget.value});
  }

  const options = formFields.map((formField) => <option key={formField}>{formField}</option>);
  const allOptions = [<option value="" key="select_field">{pleaseSelectFieldString}</option>].concat(options);

  return (
    <Form.Group controlId={'formField' + props.fieldName}>
      <Form.Label>{fieldNameLabel(fieldName)}:</Form.Label>
      <Form.Control as="select" onChange={onformActionMappingChange} defaultValue={props.defaultFormMapping[fieldName]} isInvalid={!!props.validationMessage}>
        {allOptions}
      </Form.Control>
      <Form.Control.Feedback type="invalid">{props.validationMessage}</Form.Control.Feedback>
    </Form.Group>
  );
}

export interface FormDataOptionProps {
  formData: FormData
  index: number
}

export const FormDataOption: React.FC<FormDataOptionProps> = function FormDataOption(props) {
  let textParts: string[] = [];

  if (props.formData.id) {
    textParts.push(`id="${props.formData.id}"`);
  }
  if (props.formData.name) {
    textParts.push(`name="${props.formData.name}"`);
  }
  if (props.formData.action) {
    textParts.push(`action="${props.formData.action}"`);
  }

  return (
    <option value={props.index}>{textParts.join(' ')}</option>
  );
}

export interface Step2Props {
  formsData: FormData[]
  handleWizardDataChange: (wizardData: Partial<WizardData>) => void
  formIndex: number
  formMapping: FormMapping
}

type ValidationErrors = {
  [key in FormMappingFields]?: string;
};

export interface Step2State {
  formIndex: number
  formMapping: FormMapping
  validationErrors: ValidationErrors
}

export class Step2 extends React.Component<Step2Props, Step2State> {
  static readonly REQUIRED_FIELDS: FormMappingFields[] = ["phoneNumber"]

  constructor(props: Step2Props) {
    super(props);

    this.state = {
      formIndex: this.props.formIndex || 0,
      formMapping: this.props.formMapping,
      validationErrors: this.getValidationErrors(this.props.formMapping)
    }
  }

  componentWillUnmount() {
    this.props.handleWizardDataChange({
      formMapping: this.state.formMapping,
      formIndex: this.state.formIndex
    });
  }

  onFormMappingChange = (formMappingPartial: Partial<FormMapping>) => {
    const formMapping = {...this.state.formMapping, ...formMappingPartial}
    const validationErrors = this.getValidationErrors(formMapping);
    this.setState({formMapping, validationErrors});
  }

  onformActionChange = (e: React.FormEvent<FormControlProps>) => {
    const formMapping = {}
    const validationErrors = this.getValidationErrors(formMapping);

    this.setState({formIndex: parseInt(e.currentTarget.value || '0'), formMapping, validationErrors});
  }

  isValidated() {
    return Object.keys(this.state.validationErrors).length == 0;
  }

  private getValidationErrors(formMapping: FormMapping): ValidationErrors {
    const result : ValidationErrors = {};
    Step2.REQUIRED_FIELDS.forEach((field) => {
      if (!formMapping[field]) {
        result[field] = "Must be set";
      }
    });

    return result;
  }

  render() {
    const {formsData} = this.props;
    const {validationErrors, formIndex} = this.state;

    const formFields = formsData[formIndex].fields;

    // Maybe we could take the following fields somehow from the interface itself,
    // but for now it is set manually, so we are sure that the order is correct.
    const mappingFields: FormMappingFields[] = ['name', 'firstName', 'lastName', 'phoneNumber', 'email', 'enquiry'];

    return (
      <div>
        <Form.Group controlId="formAction" className="mb-3">
          <h5>Select Form</h5>
          <Form.Control as="select" className="form_name_select" onChange={this.onformActionChange} value={formIndex.toString()}>
            { formsData.map((formData, index) => <FormDataOption key={index} index={index} formData={formData} />)}
          </Form.Control>
        </Form.Group>

        <h5>Mapping</h5>
        {mappingFields.map((field) =>
          <MappingField key={field} fieldName={field} formFields={formFields} onFormMappingChange={this.onFormMappingChange} defaultFormMapping={this.props.formMapping} validationMessage={validationErrors[field]} />
        )}
      </div>
    );
  }
}
