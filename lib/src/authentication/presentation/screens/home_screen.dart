import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_flutter/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:tdd_flutter/src/authentication/presentation/widgets/add_user_dialog.dart';
import 'package:tdd_flutter/src/authentication/presentation/widgets/loading_column.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  void getUsers() {
    context.read<AuthenticationCubit>().getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
              ),
            ),
          );
        } else if (state is UserCreated) {
          getUsers();
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: _getWidgets(state),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              // context.read<AuthenticationCubit>().createUser(
              //   createdAt: DateTime.now().toUtc().toString(),
              //   name: "nameController",
              //   avatar: "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1160.jpg",
              // );
              await showDialog(
                context: context,
                builder: (context) => AddUserDialog(
                  nameController: nameController,
                ),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text(" Add User"),
          ),
        );
      },
    );
  }

  Widget _getWidgets(state) {
    if (state is GettingUsers) {
      return const Center(child: LoadingColumn(message: "Fetching Users"));
    } else if (state is CreatingUser) {
      return const Center(child: LoadingColumn(message: "Creating User"));
    } else if (state is UsersLoaded) {
      return Center(
        child: ListView.builder(
          physics: const ClampingScrollPhysics(),
          itemCount: state.users.length,
          itemBuilder: (context, index) {
            final user = state.users[index];
            return ListTile(
              leading: Image.network(user.avatar),
              title: Text(user.name),
              subtitle: Text(user.createdAt),
            );
          },
        ),
      );
    }
    return const Center(child: SizedBox.shrink());
  }
}
