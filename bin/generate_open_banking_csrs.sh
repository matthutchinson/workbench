#!/bin/bash

# Generate a new Software Statement for your env
# When ready, run this script with your ORG id and SSA id as args
# This will generate new private keys and csrs for generating transport and
# signing certs in the OB directory dashboard

# helper to echo and execute a command
function _echo_and_execute() {
	echo $1
  eval $1
}

# check and assign args
if [ $# -lt 2 ]; then
	echo "usage: $0 Org_Id SSA_id"
	exit 1
else
	org_id=$1
	ssa_id=$2
fi

function generate_keys_and_csrs() {
	echo "OK, working with Org ID: $org_id and SSA ID: $ssa_id"
	echo

	rm -r $ssa_id
	mkdir -p $ssa_id
	mkdir -p $ssa_id/signing
	mkdir -p $ssa_id/transport

	signing_filepath=$ssa_id/signing/tpp_sig_$org_id_$ssa_id
	transport_filepath=$ssa_id/transport/tpp_trans_$org_id_$ssa_id

	_echo_and_execute "openssl genrsa -out $signing_filepath.key.pem 2048"
	_echo_and_execute "openssl req -new -sha256 \
	  -key $signing_filepath.key.pem \
	  -subj "/C=GB/O=OpenBanking/OU=$org_id/CN=$ssa_id" \
	  -out $signing_filepath.csr"

	_echo_and_execute "openssl genrsa -out $transport_filepath.key.pem 2048"
	_echo_and_execute "openssl req -new -sha256 \
	  -key $transport_filepath.key.pem \
	  -subj "/C=GB/O=OpenBanking/OU=$org_id/CN=$ssa_id" \
	  -out $transport_filepath.csr"

	echo
	echo "OK Done!"
}

function prompt_for_confirm() {
	read -p "OK to generate new signing and transport keys and CSRs in ./$ssa_id ? (y/n) " choice
	case "$choice" in
	  y|Y )
			generate_keys_and_csrs
		  ;;
	  n|N )
			echo "Phew! OK, aborting"
		  ;;
	  * )
			echo "please type y or n"
			prompt_for_confirm
		  ;;
	esac
}

prompt_for_confirm
