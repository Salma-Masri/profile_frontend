import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:testprofile/constants/colors.dart';
import 'package:testprofile/models/user.dart';
import 'package:testprofile/services/theme_provider.dart';
import 'package:testprofile/services/api.dart';
import 'package:testprofile/services/image_picker_service.dart';
import 'package:testprofile/util/validation.dart';
import 'package:testprofile/custom_widgets/common/universal_avatar.dart';

class EditProfilePage extends StatefulWidget {
  final User user;
  final ThemeProvider themeProvider;
  final Function(User) onUserUpdated;

  const EditProfilePage({
    super.key,
    required this.user,
    required this.themeProvider,
    required this.onUserUpdated,
  });

  @override
  State<EditProfilePage> createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _oldPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _cityController;
  String? profileImageUrl;
  String? idImageUrl;
  File? profileImageFile;
  File? idImageFile;
  bool isLoading = false;
  bool _obscureOldPassword = true;
  bool obscureNewPassword = true;
  bool showPasswordFields = false;

  // Error messages for inline validation
  String? _firstNameError;
  String? _lastNameError;
  String? _emailError;
  String? _phoneError;
  String? _cityError;
  String? _oldPasswordError;
  String? _newPasswordError;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.user.firstName);
    _lastNameController = TextEditingController(text: widget.user.lastName);
    _emailController = TextEditingController(text: widget.user.email ?? '');
    _phoneController = TextEditingController(
      text: widget.user.phoneNumber ?? '',
    );
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _cityController = TextEditingController(text: widget.user.city ?? '');
    // _countryController = TextEditingController(text: widget.user.country ?? '');
    profileImageUrl = widget.user.profileImage;
    idImageUrl = widget.user.identificationCard;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _cityController.dispose();
    // _countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.themeProvider.isDarkMode;
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: kApple.withValues(alpha: 0.3),
        highlightColor: kApple.withValues(alpha: 0.1),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: kApple,
          selectionColor: kApple.withValues(alpha: 0.3),
          selectionHandleColor: kKiwi,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Edit Profile',
            style: TextStyle(
              color: isDark ? Colors.white : kZeiti,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : kZeiti),
            onPressed: () => Navigator.pop(context),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              height: 1,
              color: isDark ? Colors.grey[800] : Colors.grey[300],
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4),
                      // Profile Image Section
                      Center(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                showCircleAvatar(),
                                showPositioned(isDark),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Tap to change Photo',
                              style: TextStyle(
                                color: isDark ? Colors.white : kAfani,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Form Fields - First Name and Last Name side by side
                      Row(
                        children: [
                          Expanded(
                            child: buildTextField(
                              'First Name',
                              _firstNameController,
                              isDark,
                              errorText: _firstNameError,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: buildTextField(
                              'Last Name',
                              _lastNameController,
                              isDark,
                              errorText: _lastNameError,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      buildTextField(
                        'Email Address',
                        _emailController,
                        isDark,
                        input: TextInputType.emailAddress,
                        errorText: _emailError,
                      ),
                      const SizedBox(height: 16),
                      buildTextField(
                        'Phone Number',
                        _phoneController,
                        isDark,
                        input: TextInputType.phone,
                        errorText: _phoneError,
                      ),
                      const SizedBox(height: 16),

                      buildTextField(
                        'City',
                        _cityController,
                        isDark,
                        errorText: _cityError,
                      ),
                      const SizedBox(height: 16),

                      // Change Password Button or Password Fields
                      if (!showPasswordFields)
                        buildChangePasswordButton(isDark)
                      else ...[
                        buildPasswordField(
                          'Old Password',
                          _oldPasswordController,
                          isDark,
                          _obscureOldPassword,
                          () {
                            setState(() {
                              _obscureOldPassword = !_obscureOldPassword;
                            });
                          },
                          errorText: _oldPasswordError,
                        ),
                        const SizedBox(height: 16),
                        buildPasswordField(
                          'New Password',
                          _newPasswordController,
                          isDark,
                          obscureNewPassword,
                          () {
                            setState(() {
                              obscureNewPassword = !obscureNewPassword;
                            });
                          },
                          errorText: _newPasswordError,
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: CanceButton(isDark),
                        ),
                      ],
                      const SizedBox(height: 80), // Space for fixed button
                    ],
                  ),
                ),
              ),
            ),
            // Fixed Save Button at bottom
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: saveChangesButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImageSection(
    BuildContext context,
    String title,
    String? imageUrl,
    VoidCallback onTap,
    bool isDark,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : kZeiti,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(12),
              child: imageUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return buildImagePlaceholder(isDark);
                        },
                      ),
                    )
                  : buildImagePlaceholder(isDark),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildImagePlaceholder(bool isDark) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.add_photo_alternate_outlined,
          size: 40,
          color: isDark ? Colors.grey[400] : Colors.grey[600],
        ),
        const SizedBox(height: 8),
        Text(
          'Tap to add photo',
          style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600]),
        ),
      ],
    );
  }

  Widget buildChangePasswordButton(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              showPasswordFields = true;
            });
          },
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Icon(
                  Icons.lock_outline,
                  color: isDark ? Colors.grey[400] : kZeiti,
                  size: 22,
                ),
                const SizedBox(width: 12),
                Text(
                  'Change Password',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white : kZeiti,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.chevron_right,
                  color: isDark ? Colors.grey[400] : kZeiti,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget CanceButton(bool isDark) {
    return TextButton(
      onPressed: () {
        setState(() {
          showPasswordFields = false;
          _oldPasswordController.clear();
          _newPasswordController.clear();
          _oldPasswordError = null;
          _newPasswordError = null;
        });
      },
      child: Text(
        'Cancel',
        style: TextStyle(
          color: isDark ? Colors.grey[400] : kAfani,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget buildTextField(
    String title,
    TextEditingController controller,
    bool isDark, {
    TextInputType? input,
    String? errorText,
  }) {
    bool hasError = errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : kZeiti,
          ),
        ),
        const SizedBox(height: 2),
        TextField(
          controller: controller,
          keyboardType: input,
          cursorColor: kKiwi,
          style: TextStyle(color: isDark ? Colors.white : kZeiti),
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).cardColor,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: hasError ? kOrange : Colors.grey.withValues(alpha: 0.3),
                width: hasError ? 1.5 : 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: hasError ? kOrange : kZeiti,
                width: hasError ? 1.5 : 1,
              ),
            ),
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: 4),
          Text(errorText, style: const TextStyle(color: kOrange, fontSize: 12)),
        ],
      ],
    );
  }

  Widget buildPasswordField(
    String title,
    TextEditingController controller,
    bool isDark,
    bool obscureText,
    VoidCallback onToggleVisibility, {
    String? errorText,
  }) {
    bool hasError = errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : kZeiti,
          ),
        ),
        const SizedBox(height: 2),
        TextField(
          controller: controller,
          obscureText: obscureText,
          cursorColor: kKiwi,
          style: TextStyle(color: isDark ? Colors.white : kZeiti),
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility : Icons.visibility_off,
                color: isDark ? Colors.grey[400] : kZeiti,
              ),
              onPressed: onToggleVisibility,
            ),
            filled: true,
            fillColor: Theme.of(context).cardColor,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: hasError ? kOrange : Colors.grey.withValues(alpha: 0.3),
                width: hasError ? 1.5 : 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: hasError ? kOrange : kZeiti,
                width: hasError ? 1.5 : 1,
              ),
            ),
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: 4),
          Text(errorText, style: const TextStyle(color: kOrange, fontSize: 12)),
        ],
      ],
    );
  }

  Widget _getImageWidget(String title, String? imageUrl, bool isDark) {
    File? imageFile = title == 'ID Photo' ? idImageFile : profileImageFile;

    if (imageFile != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.file(imageFile, fit: BoxFit.cover),
      );
    } else if (imageUrl != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return buildImagePlaceholder(isDark);
          },
        ),
      );
    } else {
      return buildImagePlaceholder(isDark);
    }
  }

  void changeProfileImage() {
    ImagePickerService.showImageSourceDialog(
      context,
      onImageSelected: (File file) {
        setState(() {
          profileImageFile = file;
        });
      },
      isDarkMode: widget.themeProvider.isDarkMode,
    );
  }

  void changeIdImage() {
    ImagePickerService.showImageSourceDialog(
      context,
      onImageSelected: (File file) {
        setState(() {
          idImageFile = file;
        });
      },
      isDarkMode: widget.themeProvider.isDarkMode,
    );
  }

  void saveChanges() async {
    // ========================================
    // VALIDATION - All fields must be valid
    // ========================================

    // Clear previous errors
    setState(() {
      _firstNameError = null;
      _lastNameError = null;
      _emailError = null;
      _phoneError = null;
      _cityError = null;
      _oldPasswordError = null;
      _newPasswordError = null;
    });

    // Validate all fields
    _firstNameError = Validation.validateName(
      _firstNameController.text,
      'First name',
    );
    _lastNameError = Validation.validateName(
      _lastNameController.text,
      'Last name',
    );
    _emailError = Validation.validateEmail(_emailController.text);
    _phoneError = Validation.validatePhoneNumber(_phoneController.text);
    _cityError = Validation.validateCity(_cityController.text);
    _oldPasswordError = Validation.validateOldPassword(
      _oldPasswordController.text,
      _newPasswordController.text,
    );

    if (_newPasswordController.text.isNotEmpty) {
      _newPasswordError = Validation.validatePassword(
        _newPasswordController.text,
        isRequired: true,
      );
    }

    // Check if there are any errors
    bool hasErrors =
        _firstNameError != null ||
        _lastNameError != null ||
        _emailError != null ||
        _phoneError != null ||
        _cityError != null ||
        _oldPasswordError != null ||
        _newPasswordError != null;

    if (hasErrors) {
      setState(() {}); // Refresh UI to show errors
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      String? profileImageUrl = this.profileImageUrl;
      String? idImageUrl = this.idImageUrl;

      // Upload profile image if a new one was selected
      if (profileImageFile != null) {
        profileImageUrl = await Api.uploadProfileImage(profileImageFile!);
      }

      // Upload ID image if a new one was selected
      if (idImageFile != null) {
        idImageUrl = await Api.uploadIdImage(idImageFile!);
      }

      // Determine password to save
      String? passwordToSave;
      if (_newPasswordController.text.isNotEmpty) {
        passwordToSave = _newPasswordController.text;
      }

      // Create updated user object
      final updatedUser = widget.user.copyWith(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        phoneNumber: _phoneController.text,
        city: _cityController.text,
        // country: _countryController.text,
        password: passwordToSave,
        profileImage: profileImageUrl,
        identificationCard: idImageUrl,
      );

      // Update user profile on backend
      final savedUser = await Api.updateUserProfile(updatedUser);
      widget.onUserUpdated(savedUser);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Changes saved successfully!'),
            backgroundColor: kKiwi,
          ),
        );

        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save changes: $e'),
            backgroundColor: kOrange,
          ),
        );
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Helper method to show error messages
  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: kOrange,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Widget showCircleAvatar() {
    return UniversalAvatar(
      //).profile(
      imageFile: profileImageFile,
      imageUrl: profileImageUrl,
      radius: 50,
      // showBorder: true,
      // borderWidth: 3,
    );
  }

  Widget showPositioned(bool isDark) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: isDark ? Colors.grey : kZeiti,
          borderRadius: BorderRadius.circular(30),
        ),
        child: IconButton(
          icon: const Icon(LucideIcons.camera, color: Colors.white),
          onPressed: changeProfileImage,
        ),
      ),
    );
  }

  Widget saveChangesButton() {
    final isDark = widget.themeProvider.isDarkMode;

    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: isLoading ? null : saveChanges,
        style: ElevatedButton.styleFrom(
          backgroundColor: isDark ? Colors.grey[700] : kZeiti,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Text(
                'Save Changes',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
