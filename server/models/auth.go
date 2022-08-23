package models

type SignUpBodyModel struct {
	NAME     string `json:"name,omitempty"`
	EMAIL    string `json:"email,omitempty"`
	PASSWORD string `json:"password,omitempty"`
	PHONE    string `json:"phone,omitempty"`
}

type SignInBodyModel struct {
	USERCONTACT string `json:"user_contact,omitempty"`

	PASSWORD string `json:"password,omitempty"`
}
