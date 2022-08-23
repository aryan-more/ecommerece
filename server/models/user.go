package models

type User struct {
	ID       string `json:"id,omitempty"`
	NAME     string `json:"name,omitempty"`
	EMAIL    string `json:"email,omitempty"`
	PHONE    string `json:"phone"`
	PASSWORD string `json:"password,omitempty"`
}
