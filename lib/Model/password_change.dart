class PasswordChange {
  String _currentPassword;
  String _newPassword;
  String _confirmNewPassword;

  PasswordChange(this._currentPassword, this._newPassword, this._confirmNewPassword);

  set currentPassword(currentPassword) => _currentPassword = currentPassword;

  set newPassword(newPassword) => _newPassword = newPassword;

  set confirmPassword(confirmPassword) => _confirmNewPassword = confirmPassword;

  get currentPassword => _currentPassword;

  get newPassword => _newPassword;

  get confirmPassword => _confirmNewPassword;
}