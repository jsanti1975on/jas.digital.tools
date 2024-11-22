# Objects for `frmOtherNotes`

| **Object Name**         | **Type**          | **Purpose**                                                                 |
|--------------------------|-------------------|-----------------------------------------------------------------------------|
| `txtSlipNumber`          | TextBox          | For entering slip numbers (optional when "Other" condition is met).         |
| `lblSlipNumber`          | Label            | Label for `txtSlipNumber`.                                                  |
| `cmbNoteType`            | ComboBox         | Dropdown for selecting note type (must include "Other").                    |
| `lblNoteType`            | Label            | Label for `cmbNoteType`.                                                    |
| `cmbSpecialist`          | ComboBox         | Dropdown for selecting specialist (e.g., "Jason," "Ops.Manager").           |
| `lblSpecialist`          | Label            | Label for `cmbSpecialist`.                                                  |
| `cmbSubject`             | ComboBox         | Dropdown for selecting subject (must include "Other").                      |
| `lblSubject`             | Label            | Label for `cmbSubject`.                                                     |
| `txtNotes`               | TextBox          | For entering notes (used when the "Other" condition is met).                |
| `lblOtherNote`           | Label            | Label specifically for notes when "Other" condition is met.                 |
| `lblSubmitData`          | Label            | Label for `cmdSubmit` (hidden when "Other" condition is met).               |
| `cmdSubmit`              | CommandButton    | Button to submit data for standard notes (changes background color when "Other" condition is met). |
| `lblReadNotes`           | Label            | Label for `cmdReadNotes` (hidden when "Other" condition is met).            |
| `cmdReadNotes`           | CommandButton    | Button to read notes (changes background color when "Other" condition is met). |
| `cmdOtherNoteSubmit`     | CommandButton    | Button to submit data specifically for "Other" notes.                       |
| `cmdReset`               | CommandButton    | Button to reset the form to its default state.                              |
| `lstTenantNotes`         | ListBox          | Optional: Displays logged tenant notes (for reference).                     |

---

## Notes for Setup

### ComboBox Setup:
- Ensure `cmbNoteType` and `cmbSubject` include "Other" as one of their options.
- Populate other dropdown options (e.g., "Tenant Note," "Overnight Paid," etc.).

### Initial Visibility:
- Set `lblOtherNote` and `cmdOtherNoteSubmit` to **Hidden** in the Properties pane.
- Ensure `cmdSubmit` and `cmdReadNotes` have their default background color set to match the system button color.

### Optional Enhancements:
- Include tooltips for labels and buttons to guide users during testing.

---

## Testing Checklist

1. **Verify all controls are present and named as listed above.**
2. **Test "Other" condition**:
   - Set both `cmbSubject` and `cmbNoteType` to "Other."
   - Confirm that only `txtNotes`, `lblOtherNote`, and `cmdOtherNoteSubmit` are visible.
   - Confirm `cmdSubmit` and `cmdReadNotes` change their background colors.
3. **Test Reset functionality**:
   - Ensure `cmdReset` restores all controls to their default state.
